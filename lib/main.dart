import 'package:flutter/material.dart';
import 'package:new_creations/carousel_slider.dart';
import 'package:new_creations/webscreencjange/homesc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const carouselSlider(),
    );
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
