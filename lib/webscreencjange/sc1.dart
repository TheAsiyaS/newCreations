import 'package:flutter/material.dart';

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         Center(
          child:  Text('sc 1'),
         ),
       ],
     ),
    );
  }
}