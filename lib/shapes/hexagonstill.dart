import 'dart:math';
import 'package:flutter/material.dart';

class HexagonScreen extends StatelessWidget {
  const HexagonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA89880),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: FixedHexGridPainter(),
        ),
      ),
    );
  }
}

class FixedHexGridPainter extends CustomPainter {
  final double radius = 20.0;

  // Convert axial coords (q, r) to pixel position
  Offset hexToPixel(int q, int r, Offset center) {
    const double spacingFactor = 1.2; // Increase for more space between rings
    double x = radius * sqrt(3) * (q + r / 2) * spacingFactor;
    double y = radius * 1.5 * r * spacingFactor;
    return Offset(x, y) + center;
  }

  // Generate all axial coordinates in rings 0 to 3
  List<Offset> generateHexCoords(int maxRing) {
    List<Offset> coords = [const Offset(0, 0)]; // Center hex

    final directions = [
      Offset(1, 0),
      Offset(1, -1),
      Offset(0, -1),
      Offset(-1, 0),
      Offset(-1, 1),
      Offset(0, 1),
    ];

    for (int ring = 1; ring <= maxRing; ring++) {
      Offset hex = directions[4] * ring.toDouble();

      for (int side = 0; side < 6; side++) {
        for (int step = 0; step < ring; step++) {
          coords.add(hex);
          hex += directions[side];
        }
      }
    }

    return coords;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255);

    final coords = generateHexCoords(3);
    for (final offset in coords) {
      Offset pixel = hexToPixel(offset.dx.toInt(), offset.dy.toInt(), center);
      drawHexagon(canvas, pixel, paint);
    }
  }

  void drawHexagon(Canvas canvas, Offset center, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      double angle = pi / 180 * (60 * i - 30);
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
