import 'package:flutter/material.dart';
import 'package:new_creations/webscreencjange/sc1.dart';
import 'package:new_creations/webscreencjange/sc2.dart';
import 'package:new_creations/webscreencjange/scr3.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const MyWidget1(),
    const MyWidget2(),
    const MyWidget3(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.access_alarm),
          title: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
          actions: const [Icon(Icons.hub)],
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
//Enclosed are supplementary noteworthy projects, meticulously crafted with dedication and precision