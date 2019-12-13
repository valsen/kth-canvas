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
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                title: Text('Kurser'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled),
                // title: Text('Kurser'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                title: Text('Kommande'),
              ),
            ]
          ),
          tabBuilder: (context, index) {
            // BlocProvider.of<TabBloc>(context).add(UpdateTab(activeTab == AppTab.courses ? AppTab.courses : AppTab.todos));
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: FilteredCourses()
                  );
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: AddEditScreen()
                  );
                });
                case 2:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(
                      child: FilteredTodos()
                    );
                  });
            }
          // navigationBar: CupertinoNavigationBar(
          //   middle: const Text("Canvas"),
          //   trailing: FilterButton(visible: true),
          //   // actions: [
          //   //   FilterButton(visible: true),
          //   // ],
          // ),
          // backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
          // child: activeTab == AppTab.courses ? FilteredCourses() : FilteredTodos(),

          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.add),
          //   onPressed: () {
          //     print("PUSHED");
          //     Navigator.pushNamed(context, 'addTodo');
          //   },
          // ),
          
          // : TabSelector(
          //   activeTab: activeTab,
          //   onTabSelected: (tab) =>
          //       BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          // ),
          });
      },
    );
  }
}