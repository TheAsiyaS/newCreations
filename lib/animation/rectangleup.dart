import 'package:flutter/material.dart';


class ImageStackScreen extends StatefulWidget {
  const ImageStackScreen({super.key});

  @override
  State<ImageStackScreen> createState() => _ImageStackScreenState();
}

class _ImageStackScreenState extends State<ImageStackScreen> {
  // The index of the card currently in the center
  int _currentIndex = 0;

  // --- DATA STORED IN PARALLEL LISTS ---
  // Instead of one list of objects, we have multiple lists.
  // IMPORTANT: Ensure all lists have the same number of items!

  final List<String> _imagePaths = [
     'https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg?cs=srgb&dl=pexels-jonaskakaroto-736230.jpg&fm=jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Bachelor%27s_button%2C_Basket_flower%2C_Boutonniere_flower%2C_Cornflower_-_3.jpg/960px-Bachelor%27s_button%2C_Basket_flower%2C_Boutonniere_flower%2C_Cornflower_-_3.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/cosmos-flowers-against-the-blue-sky-low-angle-royalty-free-image-1720283935.jpg?crop=0.536xw:1.00xh;0.141xw,0&resize=980:*',
    'https://hips.hearstapps.com/hmg-prod/images/bright-forget-me-nots-royalty-free-image-1677788394.jpg',
    'https://peppyflora.com/wp-content/uploads/2021/03/Mogra-Beli-Flower-Jasminum-Sambac-3x4-Product-Peppyflora-01-a-Moz.jpg',
  ];

  final List<String> _titles = [
    'Majestic Lion',
    'City at Night',
    'Vibrant Tulip',
    'Snowy Peaks',
    'The Open Road',
  ];

  final List<String> _descriptions = [
    'The king of the savannah, known for its powerful roar.',
    'A bustling metropolis illuminated by a million lights.',
    'A beautiful flower symbolizing deep love.',
    'Breathtaking view from the top of the world.',
    'An invitation to a new adventure.',
  ];

  // Function to go to the next card
  void _nextImage() {
    setState(() {
      // We use the length of any of the lists (they should all be the same)
      _currentIndex = (_currentIndex + 1) % _imagePaths.length;
    });
  }

  // Function to go to the previous card
  void _previousImage() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _imagePaths.length) % _imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Stack Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The main animated image stack
            Expanded(
              flex: 3,
              child: _buildImageStack(),
            ),

            // The animated text area
            Expanded(
              flex: 2,
              child: _buildTextContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _previousImage,
            heroTag: 'prev',
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _nextImage,
            heroTag: 'next',
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  /// Builds the text content with an AnimatedSwitcher for smooth transitions.
  Widget _buildTextContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Padding(
        key: ValueKey<int>(_currentIndex), // IMPORTANT
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Access the title from the `_titles` list
            Text(
              _titles[_currentIndex],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            // Access the description from the `_descriptions` list
            Text(
              _descriptions[_currentIndex],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the stack of cards.
  Widget _buildImageStack() {
    final screenSize = MediaQuery.of(context).size;

    // Here, we iterate over the `_imagePaths` list directly.
    final stackedItems = _imagePaths.asMap().entries.map((entry) {
      final int index = entry.key;
      final String imagePath = entry.value;

      final isCurrent = index == _currentIndex;
      final isSecond = index == (_currentIndex + 1) % _imagePaths.length;
      final isThird = index == (_currentIndex + 2) % _imagePaths.length;

      double top = screenSize.height;
      double scale = 0.7;

      if (isCurrent) {
        top = screenSize.height * 0.15;
        scale = 1.0;
      } else if (isSecond) {
        top = screenSize.height * 0.35;
        scale = 0.9;
      } else if (isThird) {
        top = screenSize.height * 0.38;
        scale = 0.8;
      }

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
        top: top,
        left: 0,
        right: 0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 700),
          curve: Curves.fastOutSlowIn,
          scale: scale,
          child: Transform.rotate(
            angle: isCurrent ? 0 : -0.1 * (index - _currentIndex),
            child: Card(
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              // Use the `imagePath` directly from our list
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: screenSize.height * 0.35,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Stack(
      alignment: Alignment.center,
      children: stackedItems.reversed.toList(),
    );
  }
}