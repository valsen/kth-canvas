import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/filtered_courses.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/bloc/blocs.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';
import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/data/models/app_tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Canvas"),
            actions: [
              FilterButton(visible: true),
            ],
          ),
          body: activeTab == AppTab.courses ? FilteredCourses() : FilteredTodos(),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}