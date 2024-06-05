import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<double> xOffsetNotifier = ValueNotifier<double>(0);
  final ValueNotifier<double> yOffsetNotifier = ValueNotifier<double>(0);
  final ValueNotifier<bool> isDrawerOpenNotifier = ValueNotifier<bool>(false);

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
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 52, 72, 84),
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(40)
                : BorderRadius.circular(0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(isDrawerOpen ? Icons.arrow_back_ios : Icons.menu),
                        onTap: toggleDrawer,
                      ),
                      Text(
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
                SizedBox(
                  height: 40,
                ),
                Column(
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
      padding: EdgeInsets.symmetric(horizontal: 35),
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
              
                Text(
                  text1,
                  style: TextStyle(
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
               
                Text(
                  text2,
                  style: TextStyle(
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