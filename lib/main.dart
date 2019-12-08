import 'package:flutter/material.dart';
import 'package:flutter_tutorial/navigation_bar_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Canvas',
      home: BottomNavigationBarController()
    );
  }
}