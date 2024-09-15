import 'package:flutter/material.dart';
import 'dart:math';

class BohrModelAnimation extends StatefulWidget {
  const BohrModelAnimation({super.key});

  @override
  _BohrModelAnimationState createState() => _BohrModelAnimationState();
}

class _BohrModelAnimationState extends State<BohrModelAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Controls the speed of orbit
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
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Nucleus
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            // Orbit paths and electrons
            // First Orbit
            ..._buildOrbit(1, 50, 2),
            // Second Orbit
            ..._buildOrbit(2, 80, 8),
            // Third Orbit
            ..._buildOrbit(3, 110, 18),
          ],
        ),
      ),
    );
  }

  // Method to build orbits and electrons
  List<Widget> _buildOrbit(int orbitNumber, double radius, int numElectrons) {
    return [
      // Orbit Path
      Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.0),
          shape: BoxShape.circle,
        ),
      ),
      // Electrons
      ...List.generate(numElectrons, (index) {
        double angle = (2 * pi / numElectrons) * index;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                radius * cos(_controller.value * 2 * pi + angle),
                radius * sin(_controller.value * 2 * pi + angle),
              ),
              child: child,
            );
          },
          // ignore: prefer_const_constructors
          child: CircleAvatar(
            radius: 5, // Size of the electrons
            backgroundColor: Colors.blue,
          ),
        );
      }),
    ];
  }
}
