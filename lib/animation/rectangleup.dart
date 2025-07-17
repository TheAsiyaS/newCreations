import 'dart:async';
import 'package:flutter/material.dart';

// Data model for our content
class ContentItem {
  final String imagePath;
  final String title;
  final String description;

  ContentItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// Enum to manage the animation sequence state
enum AnimationPhase {
  initialStack,
  exploding,
  consolidating,
  mainView,
}

class ComplexAnimationScreen extends StatefulWidget {
  const ComplexAnimationScreen({super.key});

  @override
  State<ComplexAnimationScreen> createState() => _ComplexAnimationScreenState();
}

class _ComplexAnimationScreenState extends State<ComplexAnimationScreen> {
  // --- STATE VARIABLES ---
  AnimationPhase _phase = AnimationPhase.initialStack;
  int _currentIndex = 0;
  Timer? _loopingTimer;

  // --- DATA ---
  // IMPORTANT: Make sure you have 5 images in your assets/images folder
  final List<ContentItem> _contentItems = [
    ContentItem(imagePath: 'assets/images/item1.jpg', title: 'Forest Canopy', description: 'Sunlight filtering through the dense green leaves of the forest.'),
    ContentItem(imagePath: 'assets/images/item2.jpg', title: 'Ocean Sunset', description: 'The vibrant colors of the sun setting over the calm ocean waves.'),
    ContentItem(imagePath: 'assets/images/item3.jpg', title: 'Mountain Peaks', description: 'Snow-capped mountains touching the clear blue sky.'),
    ContentItem(imagePath: 'assets/images/item4.jpg', title: 'Urban Lights', description: 'The bustling energy of a city illuminated at night.'),
    ContentItem(imagePath: 'assets/images/item5.jpg', title: 'Desert Dunes', description: 'The endless, rolling sand dunes of a vast desert landscape.'),
  ];

  // --- LIFECYCLE METHODS ---
  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  @override
  void dispose() {
    _loopingTimer?.cancel();
    super.dispose();
  }

  // --- ANIMATION CONTROL ---
  void _startAnimationSequence() {
    // After 0.5s, trigger the explosion
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _phase = AnimationPhase.exploding);
    });

    // After 1.5s total, trigger consolidation to circles at the bottom
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _phase = AnimationPhase.consolidating);
    });

    // After 2.5s total, show the main content view
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() => _phase = AnimationPhase.mainView);
        // After another 2s, start the automatic looping
        _startLoopingTimer(delay: const Duration(seconds: 2));
      }
    });
  }

  void _startLoopingTimer({Duration delay = Duration.zero}) {
    _loopingTimer?.cancel();
    _loopingTimer = Timer(delay, () {
      _loopingTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        _changeContent((_currentIndex + 1) % _contentItems.length);
      });
    });
  }

  void _changeContent(int index, {bool fromUser = false}) {
    setState(() => _currentIndex = index);
    if (fromUser) {
      // If user interacts, restart the timer for the next auto-change
      _startLoopingTimer(delay: const Duration(seconds: 2));
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complex Animation Sequence')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // This builds the 5 containers and animates them through all phases
          ..._buildAnimatedContainers(),

          // This builds the main content view (large image + text)
          // It only becomes visible in the final phase
          _buildMainContentView(),
        ],
      ),
    );
  }

  // --- WIDGET BUILDER HELPERS ---

  /// Builds the 5 animating containers
  List<Widget> _buildAnimatedContainers() {
    final screenSize = MediaQuery.of(context).size;

    // Positions for the 'exploding' phase
    final centerPos = Offset(screenSize.width / 2, screenSize.height / 2.5);
    const explodOffset = 120.0;
    final List<Offset> explodedPositions = [
      centerPos, // Center
      Offset(centerPos.dx, centerPos.dy - explodOffset), // Top
      Offset(centerPos.dx, centerPos.dy + explodOffset), // Bottom
      Offset(centerPos.dx - explodOffset, centerPos.dy), // Left
      Offset(centerPos.dx + explodOffset, centerPos.dy), // Right
    ];

    // Positions for the 'consolidating' phase (circles at the bottom)
    final double totalCircleWidth = (5 * 50.0) + (4 * 10.0);
    final double bottomStartX = (screenSize.width - totalCircleWidth) / 2;
    final List<Offset> bottomPositions = List.generate(
      5,
      (i) => Offset(bottomStartX + i * 60.0, screenSize.height - 120),
    );

    return List.generate(5, (i) {
      Offset targetPosition;
      double targetWidth = 100.0;
      double targetHeight = 200.0;
      BoxShape shape = BoxShape.rectangle;
      BorderRadius borderRadius = BorderRadius.circular(12);

      switch (_phase) {
        case AnimationPhase.initialStack:
          targetPosition = centerPos;
          break;
        case AnimationPhase.exploding:
          targetPosition = explodedPositions[i];
          break;
        case AnimationPhase.consolidating:
        case AnimationPhase.mainView:
          targetPosition = bottomPositions[i];
          targetWidth = 50.0;
          targetHeight = 50.0;
          shape = BoxShape.circle;
          borderRadius = BorderRadius.zero; // Not needed for circle shape
          break;
      }

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        top: targetPosition.dy - (targetHeight / 2),
        left: targetPosition.dx - (targetWidth / 2),
        child: GestureDetector(
          onTap: _phase == AnimationPhase.mainView
              ? () => _changeContent(i, fromUser: true)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
            width: targetWidth,
            height: targetHeight,
            decoration: BoxDecoration(
              color: _phase == AnimationPhase.mainView && i == _currentIndex
                  ? Colors.blueAccent
                  : Colors.grey.shade300,
              shape: shape,
              borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
              image: DecorationImage(
                image: AssetImage(_contentItems[i].imagePath),
                fit: BoxFit.cover,
              ),
              border: _phase == AnimationPhase.mainView && i == _currentIndex
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  /// Builds the main content view that appears in the last phase
  Widget _buildMainContentView() {
    final item = _contentItems[_currentIndex];

    return AnimatedOpacity(
      opacity: _phase == AnimationPhase.mainView ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Main Animated Image
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Container(
                key: ValueKey<String>(item.imagePath),
                width: 200,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(item.imagePath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Animated Text Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  final slideAnimation = Tween<Offset>(
                          begin: const Offset(0.0, 0.3), end: Offset.zero)
                      .animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slideAnimation, child: child),
                  );
                },
                child: Column(
                  key: ValueKey<String>(item.title),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(item.description, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}