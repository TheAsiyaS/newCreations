import 'package:flutter/material.dart';

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     body: Column(
       children: [
         Center(
          child:  Text('sc 2'),
         ),
       ],
     ),
    );
  }
}