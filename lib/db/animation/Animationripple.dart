import 'package:flutter/material.dart';
import 'dart:async';

class RippleImageSlider extends StatefulWidget {
  @override
  _RippleImageSliderState createState() => _RippleImageSliderState();
}

class _RippleImageSliderState extends State<RippleImageSlider>
    with SingleTickerProviderStateMixin {
  final List<String> images = [
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/seed/picsum/200/300',
    'https://picsum.photos/200/300?grayscale',
    'https://picsum.photos/200/300/?blur',
    'https://picsum.photos/200/300.jpg',
  ];

  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _scaleAnim = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      _controller.forward(from: 0.0);
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  List<String> getUpcomingImages() {
    List<String> upcoming = [];
    for (int i = 1; i <= 3; i++) {
      int index = (currentIndex + i) % images.length;
      upcoming.add(images[index]);
    }
    return upcoming;
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = getUpcomingImages();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnim.value,
                  child: ClipOval(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: Image.network(
                        images[currentIndex],
                        key: ValueKey(images[currentIndex]),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(upcoming.length, (i) {
                // Radius-like sizes: 60 → 40 → 20
                double size = [60.0, 40.0, 20.0][i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipOval(
                    child: Image.network(
                      upcoming[i],
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
