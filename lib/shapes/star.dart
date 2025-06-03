import 'package:flutter/material.dart';
import 'dart:math';


class StarburstBadge extends StatelessWidget {
  const StarburstBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: ClipPath(
          clipper: StarburstClipper(points: 25),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.black,
            alignment: Alignment.center,
            child: const Text(
              'TOP 1',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper for Starburst shape
class StarburstClipper extends CustomClipper<Path> {
  final int points;
  StarburstClipper({this.points = 5});

  @override
  Path getClip(Size size) {
    final double radius = size.width / 2;
    final double innerRadius = radius * 0.89;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Path path = Path();
    final double angleStep = pi / points;

    for (int i = 0; i < points * 2; i++) {
      final double angle = i * angleStep;
      final double r = (i % 2 == 0) ? radius : innerRadius;
      final double x = center.dx + r * cos(angle);
      final double y = center.dy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
