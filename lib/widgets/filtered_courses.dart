import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_tutorial/bloc/blocs.dart';
import 'package:flutter_tutorial/flutter_todos_keys.dart';
import 'package:flutter_tutorial/widgets/course_card.dart';
import 'package:flutter_tutorial/bloc/todo/todo_bloc.dart';

import '../data/models/courses_model.dart';



class FilteredCourses extends StatelessWidget {
  FilteredCourses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return CircularProgressIndicator(key: ArchSampleKeys.todosLoading);
        } else if (state is FilteredTodosLoaded) {
          final todoList = state.filteredTodos;
          final courseList = (BlocProvider.of<TodosBloc>(context).state as TodosLoaded).courseList;
          return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20),
            itemCount: courseList.length,
            itemBuilder: (context, id) {
              CanvasCourse course = courseList[id];
              return CourseCard(
                course: course,
                assignments: todoList.where((todo) => todo.courseId == course.id).toList(),
              );
            },
          ),
        ),
      ],
  );
        } else {
          return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}



Map<int, String> courseFromCode = {
  16720: "Hållut",
  12404: "ADK"
};

Widget DaysLeft(DateTime date) {
  int diffDays = date.difference(DateTime.now()).inDays + 1;
  int diffHours = date.difference(DateTime.now()).inHours + 1;
  int diffMinutes = date.difference(DateTime.now()).inMinutes + 1;
  Color color;
  if (diffDays <= 1) {
    color = Colors.red;
  } else if (diffDays < 4) {
    color = Colors.orange;
  } else {
    color = Colors.green;
  }
  return Text(
      diffHours <= 1
          ? diffMinutes.toString() + "m"
          : diffDays <= 1
              ? diffHours.toString() + 'h'
              : diffDays.toString() + "d",
      style:
          TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w400));
}