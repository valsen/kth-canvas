import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/bloc/blocs.dart';
import 'package:flutter_tutorial/flutter_todos_keys.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';

import 'package:intl/intl.dart';
import '../time_format.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) {
    TimeFormat.load("sv_SE");
  }

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
          final courseList = (BlocProvider.of<TodosBloc>(context).state as TodosLoaded).courseList;
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, id) {
                Todo todo = todoList[id];
                CanvasCourse course = courseList.firstWhere((course) => todo.courseId == course.id);
                return Column(
                  children: <Widget>[
                    Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(todo.id.toString()),
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        final VisibilityFilter activeFilter =
                            (BlocProvider.of<FilteredTodosBloc>(context).state
                                    as FilteredTodosLoaded)
                                .activeFilter;
                        BlocProvider.of<TodosBloc>(context).add(UpdateTodo(
                            todo.copyWith(
                                active: activeFilter == VisibilityFilter.active
                                    ? false
                                    : true)));
                        Scaffold.of(context).showSnackBar(
                          DeleteTodoSnackBar(
                            todo: todo,
                            onUndo: () => BlocProvider.of<TodosBloc>(context)
                                .add(UpdateTodo(todo.copyWith(
                                    active:
                                        activeFilter == VisibilityFilter.active
                                            ? true
                                            : false))),
                          ),
                        );
                      },
                      background: Container(
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
                      ),
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(todo.type == "event"
                              ? Icons.event
                              : Icons.assignment),
                          trailing: DaysLeft(todo.startAt),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(course.name),
                              Text(DateFormat.MMMEd("sv_SE")
                                  .add_Hm()
                                  .format(todo.startAt.toLocal())),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      height: 1,
                    ),
                  ],
                );
              });
        } else {
          return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
