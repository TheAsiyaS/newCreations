// flutter card movement 3,2,1 animation (fan shuffle)
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';


class FanCardAnimation extends StatefulWidget {
  const FanCardAnimation({super.key});

  @override
  _FanCardAnimationState createState() => _FanCardAnimationState();
}

class _FanCardAnimationState extends State<FanCardAnimation>
    with TickerProviderStateMixin {
  late AnimationController entryController;
  late AnimationController staggerController;

  late Animation<double> entryAnimation;
late Animation<double> blueOffsetAnim;
late Animation<double> greenOffsetAnim;
late Animation<double> redOffsetAnim;


  @override
  void initState() {
    super.initState();

    // First controller: All cards enter from left
    entryController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    entryAnimation = CurvedAnimation(
      parent: entryController,
      curve: Curves.easeOutBack,
    );

    // Second controller: stagger movement to reveal the cards
    staggerController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    blueOffsetAnim = Tween<double>(begin:0,end:  30).animate(
      CurvedAnimation(
        parent: staggerController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    greenOffsetAnim = Tween<double>(begin: 0,end: 30).animate(
      CurvedAnimation(
        parent: staggerController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );
redOffsetAnim = Tween<double>(begin: 0, end: 30).animate(
  CurvedAnimation(
    parent: staggerController,
    curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
  ),
);

    // Start animation sequence
    Future.delayed(const Duration(milliseconds: 300), () async {
      await entryController.forward();
      await staggerController.forward();
    });
  }

  Widget buildCard({
    required Color color,
    required double angle,
    required double finalDx,
    required double verticalOffset,
    required Animation<double> revealOffset,
    required double scale,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([entryAnimation, staggerController]),
      builder: (context, child) {
        final dx = lerpDouble(-200, finalDx + revealOffset.value, entryAnimation.value)!;
        final rotate = lerpDouble(0, angle, entryAnimation.value)!;
        final sc = lerpDouble(0.9, scale, entryAnimation.value)!;

        return Transform.translate(
          offset: Offset(dx, verticalOffset),
          child: Transform.rotate(
            angle: rotate,
            child: Transform.scale(
              scale: sc,
              child: child,
            ),
          ),
        );
      },
      child: Card(
        elevation: 6,
        color: color,
        child: const SizedBox(width: 120, height: 160),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Red (bottom card)
            buildCard(
              color: Colors.red.shade700,
              angle: -pi / 30,
              finalDx: -10,
              verticalOffset: 0,
              revealOffset: redOffsetAnim,
              scale: .92,
            ),

            // Green (middle)
            buildCard(
              color: Colors.green.shade700,
              angle: 0,
              finalDx: 0,
              verticalOffset: -10,
              revealOffset: greenOffsetAnim,
              scale: 0.95,
            ),

            // Blue (top card)
            buildCard(
              color: Colors.blue.shade700,
              angle: pi / 20,
              finalDx: 10,
              verticalOffset: -20,
              revealOffset: blueOffsetAnim,
              scale: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    entryController.dispose();
    staggerController.dispose();
    super.dispose();
  }
}

