import 'package:flutter/material.dart';

class AnimatedWorkCards extends StatefulWidget {
  const AnimatedWorkCards({super.key});

  @override
  State<AnimatedWorkCards> createState() => _AnimatedWorkCardsState();
}

class _AnimatedWorkCardsState extends State<AnimatedWorkCards> {
  List<double> leftPositions = List.filled(5, 0); // All start at 0
  final double cardWidth = 220;
  final List<String> cardTitles = [
    "Design",
    "Development",
    "Testing",
    "Deployment",
    "Maintenance",
  ];

  @override
  void initState() {
    super.initState();

    // Start animation after build
    Future.delayed(const Duration(milliseconds: 300), () async {
      for (int i = 1; i < 5; i++) {
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          leftPositions[i] = i * (cardWidth + 10); // add spacing
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SizedBox(
          height: size.height / 3,
          width: size.width / 1.3,
          child: Stack(
            children: List.generate(5, (index) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                top: 20,
                left: leftPositions[index],
                child: SizedBox(
                  width: cardWidth +
                      ( 10 ), // extra space for divider
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.white,
                        child: SizedBox(
                          width: cardWidth,
                          height: 200,
                          child: Center(
                            child: Text(
                              cardTitles[index],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (index != 4)
                        Container(
                          width: 1,
                          color: const Color.fromARGB(255, 136, 22, 22),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
