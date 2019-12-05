import 'package:flutter/material.dart';
import 'package:flutter_tutorial/navigation_bar_controller.dart';
import 'package:flutter_tutorial/user_model.dart';
import 'package:intl/intl.dart';


import './courses_overview.dart';
import './courses.dart';
import './todo.dart';

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

//class MyAppState extends State<MyApp> {
//  int _selectedPage = 0;
//  final _pageOptions = [
//    CoursesPage(),
//    TodoPage(),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      title: "My App",
//      theme: ThemeData(
//        colorScheme: ColorScheme.fromSwatch(),
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        drawer: Drawer(
//          child: ListView(
//            // Important: Remove any padding from the ListView.
//            padding: EdgeInsets.zero,
//            children: <Widget>[
//              DrawerHeader(
//                child: Row(
//                    children: <Widget>[
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[Icon(Icons.account_circle, color: Colors.white, size: 100,)],
//                      ),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text('Victor Josephson', style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1.2, fontWeight: FontWeight.w300)),
//                          Text('vals@kth.se', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2, fontWeight: FontWeight.w300))
//                        ]
//                      ),
//                    ]),
//                decoration: BoxDecoration(
//                          color: Colors.blue)),
//              ListTile(
//                title: Text(''),
//                onTap: () {
//                  // Update the state of the app.
//                  // ...
//                },
//              ),
//              ListTile(
//                title: Text(''),
//                onTap: () {
//                  // Update the state of the app.
//                  // ...
//                },
//              ),
//            ],
//          ),
//        ),
//        appBar: AppBar(
//          elevation: 5,
////          leading: Icon(Icons.account_circle),
//          backgroundColor: _selectedPage == 0 ? Colors.blue : Colors.purple,
//          title: Text(_selectedPage == 0 ? "Kurser" : "Att göra"),
//        ),
//        bottomNavigationBar: BottomNavigationBar(
//          selectedItemColor: _selectedPage == 0 ? Colors.blue : Colors.purple,
//          currentIndex: _selectedPage,
//          onTap: (int index) {
//            setState(() {
//              _selectedPage = index;
//            });
//          },
////          backgroundColor: Colors.lightBlueAccent,
//          items: [
//            BottomNavigationBarItem(
//              icon: new Icon(Icons.view_list),
//              title: new Text('Kurser'),
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.calendar_today),
//                title: Text('Att göra')
//            )
//          ],
//        ),
//        body: _pageOptions[_selectedPage],
//      ),
//
//    );
//  }
//}