import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/screens/add_edit_screen.dart';

import 'package:flutter_tutorial/widgets/widgets.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/data/models/models.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodoState>(builder: (context, state) {
      if (state is TodosLoaded && state.todoList.isNotEmpty) {
        // local db is empty so we display a loading screen while fetching remote data
        // display the loaded data
        return CupertinoTabScaffold(
            backgroundColor: Colors.white,
            tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                title: Text('Kurser'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                title: Text('Kommande'),
              ),
            ]),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(child: FilteredCourses());
                  });
                case 1:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(child: FilteredTodos());
                  });
                default:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(child: FilteredCourses());
                  });
              }
            });
      } else {
        return CupertinoPageScaffold(
            child: Stack(children: [
          AnimatedBackground(),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hämtar dina kurser från Canvas...',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ]),
          )
        ]));
      }
    });
  }
}
