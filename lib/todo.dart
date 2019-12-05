import 'package:flutter/material.dart';

import './todo_overview.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Att göra"),
      ),
      body: TodoOverview(),
      );
  }
}