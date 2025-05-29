import 'dart:math';
import 'package:flutter/material.dart';

class HexagonAnimationScreen extends StatefulWidget {
  const HexagonAnimationScreen({super.key});

  @override
  State<HexagonAnimationScreen> createState() =>
      _HexagonAnimationScreenState();
}

class _HexagonAnimationScreenState extends State<HexagonAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final List<Offset> directions = [
    Offset(1, 0),
    Offset(0.5, sqrt(3) / 2),
    Offset(-0.5, sqrt(3) / 2),
    Offset(-1, 0),
    Offset(-0.5, -sqrt(3) / 2),
    Offset(0.5, -sqrt(3) / 2),
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
      backgroundColor: Color.fromARGB(255, 158, 144, 123),
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
  final double progress;
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
    const double baseRadius = 30.0;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final gradient = LinearGradient(
      colors: [Color.fromARGB(255, 79, 67, 44), const Color.fromARGB(255, 130, 121, 113)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final animatedRadius = baseRadius * (1 + 0.2 * sin(progress * 2 * pi));

    paint.shader =
        gradient.createShader(Rect.fromCircle(center: center, radius: animatedRadius));
    drawHexagon(canvas, center, animatedRadius, paint);

    // Ring 1
    List<Offset> ring1Centers = [];
    for (final dir in directions) {
      final pos = center + dir * spacing;
      ring1Centers.add(pos);

      paint.shader = gradient.createShader(Rect.fromCircle(center: pos, radius: animatedRadius));
      drawHexagon(canvas, pos, animatedRadius, paint);
    }

    // Ring 2 (6 hexagons around each ring1 hex)
    for (final hexCenter in ring1Centers) {
      for (final dir in directions) {
        final pos = hexCenter + dir * spacing;

        paint.shader = gradient.createShader(Rect.fromCircle(center: pos, radius: animatedRadius));
        drawHexagon(canvas, pos, animatedRadius, paint);
      }
    }
  }

  void drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i <= 6; i++) {
      final angle = pi / 3 * i - pi / 6;
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
}
