import 'package:flutter/material.dart';
import 'dart:math';

class CircleWithRectanglesDemo extends StatelessWidget {
  const CircleWithRectanglesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circle background
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
            ),

            // Bottom left rectangle
         const   circlewithrectangles(
             colour:Color.fromARGB(255, 130, 245, 134),
              size:  Size(100, 140),
              angle: 15,
              margine:  EdgeInsets.only(bottom: 50, left: 130),
            ),

            // Bottom right rectangle
            const circlewithrectangles(
              colour: Colors.indigo,
              size:  Size(100, 140),
              angle: -15,
              margine:  EdgeInsets.only(bottom: 50, right: 130,),
            ),

            // Top center rectangle
           const circlewithrectangles(
              colour:  Color.fromARGB(255, 177, 17, 150),
              size:  Size(115, 145),
              angle: 0,
              margine:  EdgeInsets.only(bottom: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class circlewithrectangles extends StatelessWidget {
  const circlewithrectangles({
    super.key,
    required this.colour,
    required this.size,
    this.angle = 0,
    required this.margine,
  });

  final Color colour;
  final Size size;
  final double angle;
  final EdgeInsets margine;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margine,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(8),
          // image: DecorationImage(
          //   image: AssetImage(imageurl),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
