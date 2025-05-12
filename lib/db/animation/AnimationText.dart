import 'package:flutter/material.dart';

class BirdFlyTextAnimation extends StatefulWidget {
  const BirdFlyTextAnimation({super.key});

  @override
  _BirdFlyTextAnimationState createState() => _BirdFlyTextAnimationState();
}

class _BirdFlyTextAnimationState extends State<BirdFlyTextAnimation>
    with TickerProviderStateMixin {
  // Using TickerProviderStateMixin to manage multiple AnimationControllers
  late AnimationController _textController;
  late AnimationController _circleController;
  late Animation<double> _textAnimation;
  late Animation<double> _circleAnimation;
  String textToReveal = "Flutter Animation";

  @override
  void initState() {
    super.initState();

    // AnimationController for the text
    _textController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Animation for text opacity
    _textAnimation =
        Tween<double>(begin: -0.6, end: 1.0).animate(_textController)
          ..addListener(() {
            setState(() {});
          });

    // AnimationController for the CircleAvatar
    _circleController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Animation for CircleAvatar movement
    _circleAnimation =
        Tween<double>(begin: -.5, end: .65).animate(_circleController)
          ..addListener(() {
            setState(() {});
          });

    // Start both animations
    _textController.forward();
    _circleController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stationary Container with the text
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 8, 94, 102).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: textToReveal.split('').asMap().entries.map((entry) {
                  int index = entry.key;
                  String letter = entry.value;

                  return AnimatedOpacity(
                    // Adjust the condition for full text reveal
                    opacity: _textAnimation.value >
                            -0.6 + (1.5 / textToReveal.length) * index
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      letter,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 118, 216, 231)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Moving CircleAvatar
          Align(
            alignment: Alignment(
                _circleAnimation.value, 0.0), // Adjust the vertical position
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 13, 70, 75),
              radius: 30,
            ),
          ),
        ],
      ),
    );
  } 
}
