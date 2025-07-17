import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple data model for our coffee items
class Coffee {
  final String name;
  final String description;
  final String price;
  final String imagePath; // Kept for creating unique Hero tags
  final Color backgroundColor;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.backgroundColor,
  });
}

// List of coffee data that the app will loop through
final List<Coffee> coffeeData = [
  Coffee(
    name: 'Black Coffee',
    description:
        'Indulge in our creamy latte, where rich espresso meets velvety steamed milk. Perfectly balanced and crafted with care, it\'s the ultimate comfort in a cup.',
    price: '\$10.00',
    imagePath: 'assets/black_coffee.jpg', // Used for unique Hero tag
    backgroundColor: const Color(0xffa9c4c2),
  ),
  Coffee(
    name: 'Cappuccino',
    description:
        'A classic favorite, our cappuccino boasts a harmonious blend of bold espresso, steamed milk, and a luxurious layer of frothy foam. A true coffee delight.',
    price: '\$12.50',
    imagePath: 'assets/cappuccino.jpg', // Used for unique Hero tag
    backgroundColor: const Color(0xffb9967f),
  ),
  Coffee(
    name: 'Latte',
    description:
        'Savor the smooth and mellow flavors of our signature latte. A perfect pour of espresso combined with steamed milk, creating a creamy and satisfying experience.',
    price: '\$11.75',
    imagePath: 'assets/latte.jpg', // Used for unique Hero tag
    backgroundColor: const Color(0xffc5bab4),
  ),
];

// Main App Wrapper
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cofftail Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CoffeetailScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoffeetailScreen extends StatefulWidget {
  const CoffeetailScreen({super.key});

  @override
  State<CoffeetailScreen> createState() => _CoffeetailScreenState();
}

class _CoffeetailScreenState extends State<CoffeetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
  
  void _startTimer() {
    // Ensure any existing timer is cancelled before starting a new one
    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _showNextCoffee();
    });
  }
  
  void _togglePlayPause() {
    if (_timer?.isActive ?? false) {
      setState(() {
        _timer?.cancel();
      });
    } else {
      _startTimer();
    }
  }

  /// Navigates to the next coffee item in the list.
  void _showNextCoffee() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % coffeeData.length;
    });
  }

  /// Navigates to the previous coffee item in the list.
  void _showPreviousCoffee() {
    setState(() {
      // Using modulo arithmetic to safely wrap around to the end of the list
      _currentIndex = (_currentIndex - 1 + coffeeData.length) % coffeeData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          children: [
            _buildRightPanel(),
            _buildLeftPanel(),
            _buildCenterCircles(size),
            Positioned(
              top: 40,
              left: 30,
              child: Text(
                'COFFTAIL',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            // The icons widget is now interactive
            _buildStaticIcons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: MediaQuery.of(context).size.width / 2,
      child: Hero(
        tag: 'coffee_image_${coffeeData[_currentIndex].imagePath}',
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            color: coffeeData[_currentIndex].backgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      color: const Color(0xffe3ded9),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Column(
                  key: ValueKey('text_$_currentIndex'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffeeData[_currentIndex].name,
                      style: GoogleFonts.lora(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      coffeeData[_currentIndex].price,
                      style: GoogleFonts.lora(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      coffeeData[_currentIndex].description,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffb9967f),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                      ),
                      child: Text(
                        'BUY NOW',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCenterCircles(Size size) {
    return Positioned(
      left: size.width / 2 - 25,
      top: size.height / 2 - 100,
      child: Column(
        children: List.generate(coffeeData.length, (index) {
          return Opacity(
            opacity: _currentIndex == index ? 0.0 : 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Hero(
                tag: 'coffee_image_${coffeeData[index].imagePath}',
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: coffeeData[index].backgroundColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  
  // === THIS WIDGET IS NOW INTERACTIVE ===
  Widget _buildStaticIcons() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 40,
      right: 40,
      child: Column(
        children: [
          const Icon(Icons.facebook, color: Colors.black54),
          const SizedBox(height: 15),
          const Icon(Icons.video_collection, color: Colors.black54),
          SizedBox(height: size.height * 0.6),
          // Up Arrow Button
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up, color: Colors.black54, size: 30),
            onPressed: () {
              // Pause the timer and show the previous item
              _timer?.cancel();
              _showPreviousCoffee();
            },
          ),
          const SizedBox(height: 15),
          // Down Arrow Button
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 30),
            onPressed: () {
              // Pause the timer and show the next item
              _timer?.cancel();
              _showNextCoffee();
            },
          ),
        ],
      ),
    );
  }
}