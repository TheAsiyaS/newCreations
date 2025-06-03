import 'package:flutter/material.dart';
import 'package:new_creations/shapes/cardwithcircle.dart';
import 'package:new_creations/shapes/hexagon.dart';
import 'package:new_creations/shapes/hexagonstill.dart';
import 'package:new_creations/shapes/rectangletopcut.dart' show TriangleCutExample;

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: CircleWithRectanglesDemo());
  }
}
