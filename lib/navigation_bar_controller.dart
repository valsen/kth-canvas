import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/courses.dart';
import 'package:flutter_tutorial/screens/todo.dart';

class BottomNavigationBarController extends StatefulWidget {
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    CoursesPage(),
    TodoPage(),
  ];

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        selectedItemColor: _selectedIndex == 0 ? Colors.blue : Colors.purple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: Text('Kurser')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text('Att göra')),
        ],
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
