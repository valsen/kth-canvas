import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';
import 'package:flutter_tutorial/data/models/models.dart';

import '../time_format.dart';


class CourseCard extends StatelessWidget {
  final CanvasCourse course;
  final List<Todo> assignments;

  CourseCard({this.course, this.assignments}) {
    TimeFormat.load("sv_SE");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // course info
          CourseHeader(),
          // list of assignments
          Column(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: assignments.length,
                  itemBuilder: (context, id) {
                    Todo assignment = assignments[id];
                    var divider;
                    if (id < assignments.length - 1) {
                      divider = new Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 1,
                      );
                    } else {
                      divider = new Container();
                    }
                    final VisibilityFilter activeFilter =
                        (BlocProvider.of<FilteredTodosBloc>(context).state
                                as FilteredTodosLoaded)
                            .activeFilter;
                    return Column(
                      children: <Widget>[
                        DismissableCourse(
                          assignment,
                          (direction) {
                            BlocProvider.of<TodosBloc>(context).add(UpdateTodo(
                                assignment.copyWith(
                                    active: activeFilter == VisibilityFilter.active
                                        ? false
                                        : true)));
                            Scaffold.of(context).showSnackBar(
                              DeleteTodoSnackBar(
                                  todo: assignment,
                                  onUndo: () => BlocProvider.of<TodosBloc>(context)
                                      .add(UpdateTodo(assignment.copyWith(
                                          active: activeFilter ==
                                                  VisibilityFilter.active
                                              ? true
                                              : false))),
                                  key: Key(assignment.id.toString())),
                            );
                          },
                        ),
                        divider
                      ],
                    );
                  })
            ],
          ),
        ],
      ),
    );
  }

  Widget CourseHeader() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: course.color != null ? Color(int.parse(course.color.replaceAll('#', '0xff'))) : Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 7),
            child: Text(
              course.name,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 7),
            child: Text(course.courseCode,
              style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white)),
          ),
        ],
      ),
      // child: ListTile(
      //   title: Text(
      //     course.name,
      //     style: TextStyle(
      //         fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
      //   ),
      //   subtitle: Text(course.courseCode,
      //       style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white)),
      //   trailing: Icon(Icons.keyboard_arrow_right),
      //   onTap: () {},
      // ),
    );
  }

  Widget SwipeBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text("Dölj",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget DismissableCourse(assignment, onDismissed) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(
        assignment.id.toString(),
      ),
      onDismissed: onDismissed,
      background: SwipeBackground(),
      child: ListTile(
        leading: Icon(
            assignment.type == "assignment" ? Icons.assignment : Icons.event),
        title: Text(
          assignment.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: assignment.startAt != null
            ? Text(DateFormat.MMMEd("sv_SE")
                .add_Hm()
                .format(assignment.startAt.toLocal()))
            : "",
      ),
    );
  }
}


