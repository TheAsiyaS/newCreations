import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<double> xOffsetNotifier = ValueNotifier<double>(0);
  final ValueNotifier<double> yOffsetNotifier = ValueNotifier<double>(0);
  final ValueNotifier<bool> isDrawerOpenNotifier = ValueNotifier<bool>(false);

  HomeScreen({super.key});

  void toggleDrawer() {
    if (isDrawerOpenNotifier.value) {
      xOffsetNotifier.value = 0;
      yOffsetNotifier.value = 0;
      isDrawerOpenNotifier.value = false;
    } else {
      xOffsetNotifier.value = 290;
      yOffsetNotifier.value = 80;
      isDrawerOpenNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDrawerOpenNotifier,
      builder: (context, isDrawerOpen, child) {
        return AnimatedContainer(
          transform: Matrix4.translationValues(
            xOffsetNotifier.value,
            yOffsetNotifier.value,
            0,
          )
            ..scale(isDrawerOpen ? 0.85 : 1.00)
            ..rotateZ(isDrawerOpen ? -50 : 0),
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 52, 72, 84),
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(40)
                : BorderRadius.circular(0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: toggleDrawer,
                        child: Icon(isDrawerOpen ? Icons.arrow_back_ios : Icons.menu),
                      ),
                      const Text(
                        'Beautiful Drawer',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Column(
                  children: <Widget>[
                    NewPadding(
                      text1: 'Monkey',
                      text2: 'Fox',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    NewPadding(
                      text1: 'Cat',
                      text2: 'Dog',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    NewPadding(
                      text1: 'Fish',
                      text2: 'Turtle',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    NewPadding(
                      text1: 'Bird',
                      text2: 'Owl',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}



class NewPadding extends StatelessWidget {
  final String text1;
  final String text2;

  const NewPadding({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
              
                Text(
                  text1,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
               
                Text(
                  text2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}