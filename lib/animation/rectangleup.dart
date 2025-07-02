import 'package:flutter/material.dart';
import 'dart:math'; // Required for 'pi' to convert degrees to radians


class RotatingImageContainer extends StatefulWidget {
  const RotatingImageContainer({super.key});

  @override
  State<RotatingImageContainer> createState() => _RotatingImageContainerState();
}

class _RotatingImageContainerState extends State<RotatingImageContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // --- CHANGE 1: Use a list of image asset paths instead of colors ---
  final List<String> _imageAssets = [
    'https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg?cs=srgb&dl=pexels-jonaskakaroto-736230.jpg&fm=jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Bachelor%27s_button%2C_Basket_flower%2C_Boutonniere_flower%2C_Cornflower_-_3.jpg/960px-Bachelor%27s_button%2C_Basket_flower%2C_Boutonniere_flower%2C_Cornflower_-_3.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/cosmos-flowers-against-the-blue-sky-low-angle-royalty-free-image-1720283935.jpg?crop=0.536xw:1.00xh;0.141xw,0&resize=980:*',
    'https://hips.hearstapps.com/hmg-prod/images/bright-forget-me-nots-royalty-free-image-1677788394.jpg',
    'https://peppyflora.com/wp-content/uploads/2021/03/Mogra-Beli-Flower-Jasminum-Sambac-3x4-Product-Peppyflora-01-a-Moz.jpg',
  ];
  


  int _imageIndex = 0; // Renamed from _colorIndex for clarity
  int _repeatCount = 0;
  final int _maxRepeats = 5;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: -40 * (pi / 180)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _repeatCount++;
        setState(() {
          // --- CHANGE 2: Update the image index for the next cycle ---
          _imageIndex = (_repeatCount) % _imageAssets.length;
        });

        if (_repeatCount < _maxRepeats) {
          _controller.forward();
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
      } else {
        if (_repeatCount < _maxRepeats) {
          _controller.forward();
        }
      }
    });  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _handleTap,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                alignment: Alignment.centerRight,
                child: child,
              );
            },
            // --- CHANGE 3: Update the child widget to display images ---
            child: ClipRRect(
              // IMPORTANT: This clips the child (the Container's image)
              // to have rounded corners.
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  // Use 'image' property instead of 'color'
                  image: DecorationImage(
                    // Use AssetImage to load from your assets folder
                    image: NetworkImage(_imageAssets[_imageIndex]),
                    // BoxFit.cover ensures the image fills the container
                    fit: BoxFit.cover,
                  ),
                ),
                // The child text is still here, overlaid on the image
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _controller.isAnimating
                          ? "Animating...\nTap to Pause"
                          : "Paused\nTap to Resume",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}