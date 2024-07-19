import 'package:flutter/material.dart';
import 'package:new_creations/hiddendrawer/drawerscren.dart';
import 'package:new_creations/hiddendrawer/homedrawer.dart';
import 'dart:math' as math;

import 'package:new_creations/listdataIncrement.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Increment Button Example'),
        ),
        body: DataList(),
      ),
    );
  }
}
// //
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         body: Stack(
//           children: [
//             DrawerScreen(),
//             HomeScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                elevation: 20,
                color: Colors.transparent,
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 87, 78, 69), Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the value as needed
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'FLUTTER',
                        style: TextStyle(letterSpacing: 5, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      CircularSliderWidget(
                        percentage: 75, // Your skill percentage here
                        size: 100.0,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('80%'),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Last week',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(height: 50, child: VerticalDivider()),
                          Column(
                            children: [
                              Text('80%'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Last week',
                                  style: TextStyle(color: Colors.grey))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircularSliderWidget extends StatefulWidget {
  final double size;
  final int percentage;

  CircularSliderWidget({required this.size, required this.percentage});

  @override
  _CircularSliderWidgetState createState() => _CircularSliderWidgetState();
}

class _CircularSliderWidgetState extends State<CircularSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: CircularSliderPainter(
            percentage: widget.percentage,
            sliderColor: const Color.fromARGB(255, 79, 67, 44),
            baseColor: Colors.transparent,
          ),
          size: Size(widget.size, widget.size),
        ),
        Text(
          '${widget.percentage}%',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  final int percentage;
  final Color sliderColor;
  final Color baseColor;

  CircularSliderPainter({
    required this.percentage,
    required this.sliderColor,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10.0;
    final double radius = size.width / 2 - strokeWidth / 2;

    final Paint basePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint sliderPaint = Paint()
      ..color = sliderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * (percentage / 100);

    canvas.drawCircle(size.center(Offset.zero), radius, basePaint);
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      startAngle,
      sweepAngle,
      false,
      sliderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  List<Widget> pages = [
    MyPage(1),
    MyPage(2),
    MyPage(3),
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView with Remove Button'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final int pageIndex;

  MyPage(this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Page $pageIndex'),
          ElevatedButton(
            onPressed: () {
              // Remove the current page from the PageView
              Navigator.of(context).pop();
            },
            child: Text('Remove Page'),
          ),
        ],
      ),
    );
  }
}
 /*
 


  */