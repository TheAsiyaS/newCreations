import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
///////////////////////////////////////////////////// b2
class BeehiveAnimationPage extends StatefulWidget {
  const BeehiveAnimationPage({super.key});

  @override
  State<BeehiveAnimationPage> createState() => _BeehiveAnimationPageState();
}

class _BeehiveAnimationPageState extends State<BeehiveAnimationPage>
    with TickerProviderStateMixin { // <-- MODIFIED: Need TickerProviderStateMixin for two controllers
  // <-- NEW: Two controllers for two animation phases
  late AnimationController _growthController;
  late AnimationController _driftController;

  List<Hex> _hive = [];
  final random = Random();

  // --- Animation & Hive Configuration ---
  final int hiveRadius = 7;
  final double hexSize = 30.0;
  final double spacingFactor = 0.9;
  // <-- NEW: Controls how far the hexagons drift from their position
  final double driftAmount = 4.0;

  final List<Color> _honeyColors = [
    const Color(0xFFFFC107), const Color(0xFFFFD54F),
    const Color(0xFFFFB300), const Color(0xFFFFCA28),
    const Color(0xFFFFE082), const Color(0xFFFFA000),
    const Color(0xFFFB8C00),
  ];

  @override
  void initState() {
    super.initState();
    // Controller for the initial growth animation
    _growthController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    // Controller for the continuous drifting animation
    _driftController = AnimationController(
      duration: const Duration(seconds: 10), // Speed of one drift cycle
      vsync: this,
    );

    // When the growth is complete, start the drifting animation
    _growthController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _driftController.repeat(); // Loop the drift animation
      }
    });

    _generateHive();
    _growthController.forward();
  }

  void _generateHive() {
    final List<Hex> growthOrder = [];
    final Set<Hex> visited = {};
    final Queue<Hex> queue = Queue();

    final centerHex = Hex(
      0, 0, 0,
      _honeyColors[random.nextInt(_honeyColors.length)],
      // <-- NEW: Generate drift properties for the center hex
      driftOffset: Offset(
        (random.nextDouble() - 0.5) * driftAmount,
        (random.nextDouble() - 0.5) * driftAmount,
      ),
      driftPhase: random.nextDouble(),
    );
    queue.add(centerHex);
    visited.add(centerHex);
    growthOrder.add(centerHex);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      for (final neighbor in current.getNeighbors()) {
        if (!visited.contains(neighbor) && neighbor.distanceFromCenter() <= hiveRadius) {
          visited.add(neighbor);
          final newHex = Hex(
            neighbor.q, neighbor.r, neighbor.s,
            _honeyColors[random.nextInt(_honeyColors.length)],
            // <-- NEW: Generate unique drift properties for each new hex
            driftOffset: Offset(
              (random.nextDouble() - 0.5) * driftAmount,
              (random.nextDouble() - 0.5) * driftAmount,
            ),
            driftPhase: random.nextDouble(),
          );
          queue.add(newHex);
          growthOrder.add(newHex);
        }
      }
    }
    setState(() { _hive = growthOrder; });
  }

  void _restartAnimation() {
    _driftController.stop(); // Stop the old drift
    _driftController.reset();
    _growthController.reset();
    _generateHive();
    _growthController.forward(); // Start the growth again
  }

  @override
  void dispose() {
    // <-- MODIFIED: Dispose of both controllers
    _growthController.dispose();
    _driftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3436),
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              // <-- MODIFIED: Listen to both controllers for updates
              animation: Listenable.merge([_growthController, _driftController]),
              builder: (context, child) {
                return CustomPaint(
                  size: Size.square((hiveRadius * 2 + 1) * hexSize + driftAmount * 2),
                  painter: BeehivePainter(
                    hive: _hive,
                    // <-- MODIFIED: Pass both progress values to the painter
                    growthProgress: _growthController.value,
                    driftProgress: _driftController.value,
                    hexSize: hexSize,
                    spacingFactor: spacingFactor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 30, left: 0, right: 0,
            child: Center(
              child: FloatingActionButton.extended(
                onPressed: _restartAnimation,
                icon: const Icon(Icons.refresh),
                label: const Text('Regenerate'),
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// --- The Custom Painter for Drawing the Hive ---
class BeehivePainter extends CustomPainter {
  final List<Hex> hive;
  final double growthProgress;
  // <-- NEW: Progress for the drift animation (0.0 to 1.0, repeating)
  final double driftProgress;
  final double hexSize;
  final double spacingFactor;

  BeehivePainter({
    required this.hive,
    required this.growthProgress,
    required this.driftProgress, // <-- NEW
    required this.hexSize,
    required this.spacingFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 1.5;

    final int hexagonsToShow = (hive.length * growthProgress).floor();
    final double visualHexSize = hexSize * spacingFactor;

    for (int i = 0; i < hexagonsToShow; i++) {
      final hex = hive[i];
      // Start with the hex's original, static position
      var hexCenter = hex.toPixel(center, hexSize);

      // <-- NEW: Apply drift *after* growth is complete
      if (growthProgress == 1.0) {
        // Use a sine wave for smooth, back-and-forth motion
        final driftAngle = 2 * pi * (driftProgress + hex.driftPhase);
        final driftOffset = Offset(
          hex.driftOffset.dx * sin(driftAngle),
          hex.driftOffset.dy * sin(driftAngle),
        );
        hexCenter += driftOffset;
      }

      double hexScaleProgress = 1.0;
      if (i == hexagonsToShow - 1 && growthProgress < 1.0) {
        hexScaleProgress = (growthProgress * hive.length) - hexagonsToShow + 1;
      }

      final hexPath = _createHexagonPath(hexCenter, visualHexSize * hexScaleProgress);
      final hexColor = hex.color;
      final animationOpacity = (0.8 * hexScaleProgress);

      fillPaint.color = hexColor.withOpacity(animationOpacity);
      borderPaint.color = Colors.black.withOpacity(0.2 * hexScaleProgress);

      canvas.drawPath(hexPath, fillPaint);
      canvas.drawPath(hexPath, borderPaint);
    }
  }

  Path _createHexagonPath(Offset center, double size) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i + (pi / 6);
      final point = Offset(center.dx + size * cos(angle), center.dy + size * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant BeehivePainter oldDelegate) {
    // <-- MODIFIED: Repaint if either progress value changes
    return oldDelegate.growthProgress != growthProgress ||
        oldDelegate.driftProgress != driftProgress ||
        oldDelegate.hive != hive;
  }
}

// --- Hexagon Data and Logic Class ---
class Hex {
  final int q;
  final int r;
  final int s;
  final Color color;
  // <-- NEW: Properties to give each hex its own unique movement
  final Offset driftOffset;
  final double driftPhase;

  Hex(this.q, this.r, this.s, this.color,
      {required this.driftOffset, required this.driftPhase}) { // <-- NEW
    assert(q + r + s == 0, "Hex coordinates must sum to 0");
  }

  int distanceFromCenter() {
    return (q.abs() + r.abs() + s.abs()) ~/ 2;
  }

  static final List<Hex> directions = [
    Hex(1, 0, -1, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
    Hex(1, -1, 0, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
    Hex(0, -1, 1, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
    Hex(-1, 0, 1, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
    Hex(-1, 1, 0, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
    Hex(0, 1, -1, Colors.transparent, driftOffset: Offset.zero, driftPhase: 0),
  ];

  Hex operator +(Hex other) {
    return Hex(q + other.q, r + other.r, s + other.s, color,
        driftOffset: driftOffset, driftPhase: driftPhase);
  }

  List<Hex> getNeighbors() {
    return directions.map((dir) => this + dir).toList();
  }

  Offset toPixel(Offset center, double size) {
    final double x = size * (3 / 2 * q);
    final double y = size * (sqrt(3) / 2 * q + sqrt(3) * r);
    return Offset(x + center.dx, y + center.dy);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hex &&
          runtimeType == other.runtimeType &&
          q == other.q &&
          r == other.r &&
          s == other.s;

  @override
  int get hashCode => q.hashCode ^ r.hashCode ^ s.hashCode;
}