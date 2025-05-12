// flutter card movement 3,2,1 animation (fan shuffle)


import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class FanCardAnimation extends StatefulWidget {
  @override
  _FanCardAnimationState createState() => _FanCardAnimationState();
}

class _FanCardAnimationState extends State<FanCardAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFanned = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void toggleFan() {
    setState(() {
      isFanned = !isFanned;
      if (isFanned) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget buildCard(Color color, double angle, double offset, int index) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final rotate = lerpDouble(0, angle, _animation.value)!;
        final dx = lerpDouble(0, offset, _animation.value)!;
        return Transform.translate(
          offset: Offset(dx, -index * 10.0),
          child: Transform.rotate(
            angle: rotate,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 8,
        color: color,
        child: SizedBox(width: 120, height: 160),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fan Shuffle Animation')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildCard(Colors.red, -pi / 8, -60, 2),
            buildCard(Colors.green, 0, 0, 1),
            buildCard(Colors.blue, pi / 8, 60, 0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleFan,
        child: Icon(Icons.shuffle),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
