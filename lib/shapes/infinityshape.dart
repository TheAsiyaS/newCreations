import 'dart:math';
import 'package:flutter/material.dart';

class HexagonAnimationScreen extends StatefulWidget {
  const HexagonAnimationScreen({super.key});

  @override
  State<HexagonAnimationScreen> createState() => _HexagonAnimationScreenState();
}

class _HexagonAnimationScreenState extends State<HexagonAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  // 6 directions of hex grid (pointy topped)
  final List<Offset> directions = [
    Offset(1, 0), // right
    Offset(0.5, sqrt(3) / 2), // bottom-right
    Offset(-0.5, sqrt(3) / 2), // bottom-left
    Offset(-1, 0), // left
    Offset(-0.5, -sqrt(3) / 2), // top-left
    Offset(0.5, -sqrt(3) / 2), // top-right
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final center = MediaQuery.of(context).size.center(Offset.zero);

    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return CustomPaint(
            painter: HexagonPainter(
              progress: controller.value,
              center: center,
              directions: directions,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final double progress; // 0 to 1
  final Offset center;
  final List<Offset> directions;

  HexagonPainter({
    required this.progress,
    required this.center,
    required this.directions,
  });

@override
void paint(Canvas canvas, Size size) {
  const double spacing = 80.0;
  const double hexRadius = 30.0;
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final gradient = LinearGradient(
    colors: [Colors.blue, Colors.white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Use axial coordinates to keep track of visited hexes
  Set<Offset> visited = {};

  // Define the hex directions for axial coordinates
  List<Offset> axialDirs = [
    const Offset(1, 0),
    const Offset(1, -1),
    const Offset(0, -1),
    const Offset(-1, 0),
    const Offset(-1, 1),
    const Offset(0, 1),
  ];

  void drawRecursive(Offset axial, int depth) {
    if (depth == 0 || visited.contains(axial)) return;
    visited.add(axial);

    Offset pixel = _axialToPixel(axial, spacing);
    paint.shader = gradient.createShader(Rect.fromCircle(center: center + pixel, radius: hexRadius));
    drawHexagon(canvas, center + pixel, hexRadius, paint);

    for (Offset dir in axialDirs) {
      drawRecursive(axial + dir, depth - 1);
    }
  }

  drawRecursive(const Offset(0, 0), 2); // depth 2: center + 6 + 36
}

  /// Convert hex axial coords (ring, step, side) to pixel offset (relative to center)
  /// ring = distance from center, step = index along ring side, side = which of 6 directions
  Offset _hexToPixel(double ring, double step, int side, double spacing) {
    // Each ring has 6 sides, each with 'ring' hexes.
    // Start at direction 'side' * ring and move along next direction.
    // Directions for corners:
    final List<Offset> corners = [
      Offset(1, 0),
      Offset(0.5, sqrt(3) / 2),
      Offset(-0.5, sqrt(3) / 2),
      Offset(-1, 0),
      Offset(-0.5, -sqrt(3) / 2),
      Offset(0.5, -sqrt(3) / 2),
    ];

    Offset start = corners[side] * ring * spacing;
    Offset next = corners[(side + 1) % 6] * step * spacing;

    return start + next;
  }

  void drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i <= 6; i++) {
      final angle = pi / 3 * i - pi / 6; // rotate to pointy-top hexagon
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) => true;
  
Offset _axialToPixel(Offset axial, double spacing) {
  double x = spacing * (sqrt(3) * axial.dx + sqrt(3) / 2 * axial.dy);
  double y = spacing * (3 / 2 * axial.dy);
  return Offset(x, y);
}
}
