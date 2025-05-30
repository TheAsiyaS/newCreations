import 'package:flutter/material.dart';
import 'package:new_creations/shapes/hexagon.dart';

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
        home: HexagonAnimationScreen());
  }
}
