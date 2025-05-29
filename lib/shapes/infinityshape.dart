import 'package:flutter/material.dart';
import 'dart:math';


class Honeycomb3DBackground extends StatelessWidget {
  const Honeycomb3DBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: Size.infinite,
        painter: Honeycomb3DPainter(),
      ),
    );
  }
}

class Honeycomb3DPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 30;
    final double hexHeight = sqrt(3) * radius;
    final double hexWidth = 2 * radius;
    final double vertSpacing = hexHeight;
    final double horizSpacing = 1.5 * radius;

    for (double y = 0; y < size.height + hexHeight; y += vertSpacing) {
      for (double x = 0; x < size.width + hexWidth; x += horizSpacing) {
        final offsetX = x + ((y ~/ vertSpacing) % 2 == 0 ? 0 : radius * 0.75);
        final offset = Offset(offsetX, y);
        _draw3DHexagon(canvas, offset, radius);
      }
    }
  }

  void _draw3DHexagon(Canvas canvas, Offset center, double radius) {
    final Path top = Path();
    final Path left = Path();
    final Path right = Path();

    final points = List<Offset>.generate(6, (i) {
      final angle = pi / 3 * i - pi / 6;
      return Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    });

    // Create 3D effect by drawing 3 faces
    top.moveTo(points[0].dx, points[0].dy);
    top.lineTo(points[1].dx, points[1].dy);
    top.lineTo(points[2].dx, points[2].dy);
    top.lineTo(center.dx, center.dy);
    top.close();

    right.moveTo(points[2].dx, points[2].dy);
    right.lineTo(points[3].dx, points[3].dy);
    right.lineTo(points[4].dx, points[4].dy);
    right.lineTo(center.dx, center.dy);
    right.close();

    left.moveTo(points[4].dx, points[4].dy);
    left.lineTo(points[5].dx, points[5].dy);
    left.lineTo(points[0].dx, points[0].dy);
    left.lineTo(center.dx, center.dy);
    left.close();

    canvas.drawPath(top, Paint()..color = Colors.amber.shade300);
    canvas.drawPath(right, Paint()..color = Colors.orange.shade700);
    canvas.drawPath(left, Paint()..color = Colors.orange.shade400);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
