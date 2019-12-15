import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';

import 'package:intl/intl.dart';

class TodoRowItem extends StatelessWidget {
  const TodoRowItem({
    this.index,
    this.todo,
    this.course,
    this.lastItem
  });

  final int index;
  final Todo todo;
  final CanvasCourse course;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final VisibilityFilter activeFilter =
      (BlocProvider.of<FilteredTodosBloc>(context).state as FilteredTodosLoaded).activeFilter;
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 6,
        top: 16,
        bottom: 16,
        right: 8,
      ),
      child: IntrinsicHeight(
        child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    todo.title,
                  ),
                  Text(
                    course.name,
                    style: TextStyle(fontSize: 14, color: courseColor(course)),
                  ),
                  Text(DateFormat.MMMEd("sv_SE")
                      .add_Hm().format(todo.startAt.toLocal()),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(todo.type == "event" ? Icons.event : Icons.assignment, color: Colors.grey),
                // : CupertinoButton(
                //   minSize: 5,
                //   // color: Colors.green,
                //     padding: EdgeInsets.zero,
                //     child: Text('Markera aktiv', style: TextStyle(fontSize: 18)),
                //     onPressed: () {
                //       if (activeFilter == VisibilityFilter.inactive) {
                //         BlocProvider.of<TodosBloc>(context).add(UpdateTodo(todo.copyWith(
                //           active: activeFilter == VisibilityFilter.active
                //             ? false
                //             : true)));
                //       }
                //     },
                // ),
              daysLeft(todo.startAt),
            ]),
          ],
      )
    ),
    );

    if (lastItem) {
      return row;
    }

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            row,
            Divider(height:0)
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 20,
            //   ),
            //   child: Container(
            //     height: 0.5,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        );
      });
  }
}

Color courseColor(CanvasCourse course) {
  return course.color != null 
    ? Color(int.parse(course.color.replaceAll('#', '0xff')))
    : Colors.blueGrey;
}