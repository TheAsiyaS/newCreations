import 'package:flutter/material.dart';

class ConnectingLinesScreen extends StatefulWidget {
  @override
  _ConnectingLinesScreenState createState() => _ConnectingLinesScreenState();
}

class _ConnectingLinesScreenState extends State<ConnectingLinesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connecting Lines')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double centerX = constraints.maxWidth / 2;
          final double centerY = constraints.maxHeight / 2;
          final double containerSize = 50;

          return Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(width: containerSize, height: containerSize, color: Colors.red),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(width: containerSize, height: containerSize, color: Colors.red),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(width: containerSize, height: containerSize, color: Colors.red),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(width: containerSize, height: containerSize, color: Colors.red),
              ),
              CustomPaint(
                painter: LinePainter(_controller, centerX, centerY, containerSize),
                child: Container(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Animation<double> animation;
  final double centerX;
  final double centerY;
  final double containerSize;

  LinePainter(this.animation, this.centerX, this.centerY, this.containerSize) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    final double endFraction = animation.value;

    final points = [
      Offset(0 + containerSize / 2, 0 + containerSize / 2),
      Offset(size.width - containerSize / 2, 0 + containerSize / 2),
      Offset(0 + containerSize / 2, size.height - containerSize / 2),
      Offset(size.width - containerSize / 2, size.height - containerSize / 2),
    ];

    for (var point in points) {
      final endX = centerX + (point.dx - centerX) * endFraction;
      final endY = centerY + (point.dy - centerY) * endFraction;
      canvas.drawLine(Offset(centerX, centerY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.animation != animation ||
           oldDelegate.centerX != centerX ||
           oldDelegate.centerY != centerY ||
           oldDelegate.containerSize != containerSize;
  }
}
