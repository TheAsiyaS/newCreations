// used in personal website top corner
import 'package:flutter/material.dart';



class TriangleCutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: TopLeftTriangleClipper(),
          child: Container(
            width: 300,
            height: 600,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class TopLeftTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Starting from top-left corner
    path.moveTo( size.height/2, 0);               // Move right to create the triangle base
    path.lineTo(0,  size.height/3);               // Draw line down to triangle tip
    path.lineTo(0, size.height);      // Left edge
    path.lineTo(size.width, size.height); // Bottom edge
    path.lineTo(size.width, 0);       // Right edge
    path.close();                     // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
 