import 'package:flutter/material.dart';
import 'package:new_creations/db/animation/Animationcardmove.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FanCardAnimation());
  }
}
