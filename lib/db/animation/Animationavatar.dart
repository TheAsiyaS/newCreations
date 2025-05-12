import 'package:flutter/material.dart';
import 'dart:math' as math;



class SpinningContainersScreen extends StatefulWidget {
  const SpinningContainersScreen({super.key});

  @override
  _SpinningContainersScreenState createState() =>
      _SpinningContainersScreenState();
}

class _SpinningContainersScreenState extends State<SpinningContainersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
   
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spinning Containers')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            _buildAnimatedContainer(0),
            _buildAnimatedContainer(90),
            _buildAnimatedContainer(180),
            _buildAnimatedContainer(270),
          ],
        ),
      ),
    );
  }// circle avatater radius : 40 , background colour :  colors.blue child : icons(icons.person,szize :40,coloes: kwhite );

  Widget _buildAnimatedContainer(double angle) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: 30,
        height: 30,
        color: Colors.red,
      ),
      builder: (context, child) {
        const double radius = 100;
        final double radians = angle * (math.pi / 180);
        final double x = radius * math.cos(_controller.value * 2 * math.pi + radians);
        final double y = radius * math.sin(_controller.value * 2 * math.pi + radians);
        return Transform.translate(
          offset: Offset(x, y),
          child: child,
        );
      },
    );
  }
}