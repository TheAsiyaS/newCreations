import 'package:flutter/material.dart';
import 'dart:math';

class SolarSystemAnimation extends StatefulWidget {
  const SolarSystemAnimation({super.key});

  @override
  _SolarSystemAnimationState createState() => _SolarSystemAnimationState();
}

class _SolarSystemAnimationState extends State<SolarSystemAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Controls the speed of rotation
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Central Circle
            const CircleAvatar(
              radius: 50, // Adjust the size of the central circle
              backgroundColor: Colors.blue,
            ),
            // Rotating Balls
            ...List.generate(5, (index) {
              double angle = (2 * pi / 5) * index;
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      100 * cos(_controller.value * 3 * pi / 2 + angle),
                      100 * sin(_controller.value * 2 * pi/5 + angle),
                    ),
                    child: child,
                  );
                },
                child: const CircleAvatar(
                  radius: 10, // Adjust the size of the rotating balls
                  backgroundColor: Colors.orange,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
