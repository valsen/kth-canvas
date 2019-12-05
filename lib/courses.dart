import 'package:flutter/material.dart';

import './courses_overview.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Kurser"),
      ),
      body: CoursesOverview(),
    );
  }
}