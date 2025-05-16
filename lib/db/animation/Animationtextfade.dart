import 'package:flutter/material.dart';

class AnimatedTextList extends StatefulWidget {
  const AnimatedTextList({super.key});

  @override
  State<AnimatedTextList> createState() => _AnimatedTextListState();
}

class _AnimatedTextListState extends State<AnimatedTextList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> texts = ["*Hello", "*Welcome", "*To", "*Flutter", "*Animation"];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildAnimatedText(String text, int index) {
    final animationInterval = 1.0 / texts.length;
    final start = animationInterval * index;
    final end = start + animationInterval;

    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.2),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(text, style: TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        texts.length,
        (index) => buildAnimatedText(texts[index], index),
      ),
    );
  }
}
