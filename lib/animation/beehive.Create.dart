import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';



class BeehiveAnimationPage extends StatefulWidget {
  const BeehiveAnimationPage({super.key});

  @override
  State<BeehiveAnimationPage> createState() => _BeehiveAnimationPageState();
}

class _BeehiveAnimationPageState extends State<BeehiveAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Hex> _hive = [];
  final random = Random();

  // --- Animation & Hive Configuration ---
  // <-- MODIFIED: Replaced maxHexagons with a clear radius.
  // The center is ring 0, so a radius of 7 creates 7 outer rings.
  final int hiveRadius = 5;
  final double hexSize = 30.0;
  final double spacingFactor = 0.9;

  // A beautiful palette of honey-like colors
  final List<Color> _honeyColors = [
    const Color(0xFFFFC107), // Amber
    const Color(0xFFFFD54F), // Amber[300]
    const Color(0xFFFFB300), // Amber[700]
    const Color(0xFFFFCA28), // Amber[400]
    const Color(0xFFFFE082), // Amber[200]
    const Color(0xFFFFA000), // Amber[800]
    const Color(0xFFFB8C00), // Orange[600]
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // <-- MODIFIED: Shorter duration for a smaller hive.
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _generateHive();
    _controller.forward();
  }

  void _generateHive() {
    final List<Hex> growthOrder = [];
    final Set<Hex> visited = {};
    final Queue<Hex> queue = Queue();

    final centerHex = Hex(
      0, 0, 0,
      _honeyColors[random.nextInt(_honeyColors.length)],
    );
    queue.add(centerHex);
    visited.add(centerHex);
    growthOrder.add(centerHex);

    // <-- MODIFIED: The loop condition is simpler now.
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      final neighbors = current.getNeighbors();

      for (final neighbor in neighbors) {
        // <-- MODIFIED: The main logic change is here!
        // We now check if the neighbor is within our desired radius
        // before adding it to the hive.
        if (!visited.contains(neighbor) &&
            neighbor.distanceFromCenter() <= hiveRadius) {
          visited.add(neighbor);
          final newHex = Hex(
            neighbor.q, neighbor.r, neighbor.s,
            _honeyColors[random.nextInt(_honeyColors.length)],
          );
          queue.add(newHex);
          growthOrder.add(newHex);
        }
      }
    }
    setState(() {
      _hive = growthOrder;
    });
  }

  void _restartAnimation() {
    _generateHive();
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added a background color to better see the hive
      backgroundColor: const Color(0xFF2D3436),
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  // We don't need double.infinity anymore. We can give it a specific
                  // size to contain our hive, which is more efficient.
                  // (radius * 2 + 1) * hexSize gives a good bounding box.
                  // <-- MODIFIED: Sized the painter to fit the hive.
                  size: Size.square((hiveRadius * 2 + 1) * hexSize),
                  painter: BeehivePainter(
                    hive: _hive,
                    progress: _controller.value,
                    hexSize: hexSize,
                    spacingFactor: spacingFactor,
                  ),
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}

// --- The Custom Painter for Drawing the Hive ---
// No changes needed here, but I've removed the culling logic as it's
// not necessary for a small, fixed-size hive.
class BeehivePainter extends CustomPainter {
  final List<Hex> hive;
  final double progress;
  final double hexSize;
  final double spacingFactor;

  BeehivePainter({
    required this.hive,
    required this.progress,
    required this.hexSize,
    required this.spacingFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final int hexagonsToShow = (hive.length * progress).floor();
    final double visualHexSize = hexSize * spacingFactor;

    for (int i = 0; i < hexagonsToShow; i++) {
      final hex = hive[i];
      final hexCenter = hex.toPixel(center, hexSize);

      double hexProgress = 1.0;
      if (i == hexagonsToShow - 1 && progress < 1.0) {
        hexProgress = (progress * hive.length) - hexagonsToShow + 1;
      }

      final hexPath = _createHexagonPath(hexCenter, visualHexSize * hexProgress);
      final hexColor = hex.color;
      final animationOpacity = (0.8 * hexProgress);

      fillPaint.color = hexColor.withOpacity(animationOpacity);
      borderPaint.color = Colors.black.withOpacity(0.2 * hexProgress);

      canvas.drawPath(hexPath, fillPaint);
      canvas.drawPath(hexPath, borderPaint);
    }
  }

  Path _createHexagonPath(Offset center, double size) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i + (pi / 6);
      final point = Offset(
        center.dx + size * cos(angle),
        center.dy + size * sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant BeehivePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.hive != hive;
  }
}

// --- Hexagon Data and Logic Class ---
class Hex {
  final int q;
  final int r;
  final int s;
  final Color color;

  Hex(this.q, this.r, this.s, this.color) {
    assert(q + r + s == 0, "Hex coordinates must sum to 0");
  }

  //<-- NEW: Helper method to calculate distance from the center hex (0,0,0).
  int distanceFromCenter() {
    // In cube coordinates, distance is half the sum of the absolute values.
    // We use integer division `~/` to get a whole number.
    return (q.abs() + r.abs() + s.abs()) ~/ 2;
  }

  static final List<Hex> directions = [
    Hex(1, 0, -1, Colors.transparent), Hex(1, -1, 0, Colors.transparent),
    Hex(0, -1, 1, Colors.transparent), Hex(-1, 0, 1, Colors.transparent),
    Hex(-1, 1, 0, Colors.transparent), Hex(0, 1, -1, Colors.transparent),
  ];

  Hex operator +(Hex other) {
    return Hex(q + other.q, r + other.r, s + other.s, color);
  }

  List<Hex> getNeighbors() {
    return directions.map((dir) => this + dir).toList();
  }

  Offset toPixel(Offset center, double size) {
    final double x = size * (3 / 2 * q);
    final double y = size * (sqrt(3) / 2 * q + sqrt(3) * r);
    return Offset(x + center.dx, y + center.dy);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hex &&
          runtimeType == other.runtimeType &&
          q == other.q &&
          r == other.r &&
          s == other.s;

  @override
  int get hashCode => q.hashCode ^ r.hashCode ^ s.hashCode;
}