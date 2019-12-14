import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';
import 'package:flutter_tutorial/data/models/models.dart';

class FilteredCourses extends StatelessWidget {
  FilteredCourses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return Center(
              child:
                  CircularProgressIndicator(key: ArchSampleKeys.todosLoading));
        } else if (state is FilteredTodosLoaded) {
          final todoList = state.filteredTodos;
          final courseList =
              (BlocProvider.of<TodosBloc>(context).state as TodosLoaded)
                  .courseList;
          return CustomScrollView(
            semanticChildCount: courseList.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('Kurser'),
                trailing:
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                  CupertinoSegmentedControl(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    borderColor: Colors.blueGrey,
                    selectedColor: Colors.blueGrey,
                    children: {
                      VisibilityFilter.inactive: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child:
                              Text('Inaktiva', style: TextStyle(fontSize: 14))),
                      VisibilityFilter.active: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Text('Aktiva', style: TextStyle(fontSize: 14)))
                    },
                    groupValue: (BlocProvider.of<FilteredTodosBloc>(context)
                            .state as FilteredTodosLoaded)
                        .activeFilter,
                    onValueChanged: (filter) {
                      BlocProvider.of<FilteredTodosBloc>(context).add(
                          UpdateFilter(filter == VisibilityFilter.active
                              ? VisibilityFilter.active
                              : VisibilityFilter.inactive));
                    },
                  ),
                ]),
              ),
              SliverSafeArea(
                // BEGINNING OF NEW CONTENT
                top: false,
                //  minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < courseList.length) {
                        CanvasCourse course = courseList[index];
                        return CourseCard(
                          // index: index,
                          course: course,
                          assignments: todoList
                              .where((todo) => todo.courseId == course.id)
                              .toList(),
                          //  lastItem: index == todoList.length - 1,
                        );
                      }
                      return null;
                    },
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}

Widget daysLeft(DateTime date) {
  final DateTime then = DateTime(date.year, date.month, date.day);
  final DateTime now = DateTime.now();
  final int diffDays =
      then.difference(DateTime(now.year, now.month, now.day)).inDays;
  final int diffHours = date.difference(DateTime.now()).inHours + 1;
  final int diffMinutes = date.difference(DateTime.now()).inMinutes + 1;
  final Color color =
      diffDays <= 1 ? Colors.red : diffDays <= 3 ? Colors.orange : Colors.green;

  return Text(
      diffHours <= 1
          ? diffMinutes.toString() + "m"
          : diffHours < 24
              ? "<" + diffHours.toString() + 'h'
              : diffDays.toString() + "d",
      style:
          TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w400));
}
