import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/data/models/visibility_filter.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_tutorial/bloc/blocs.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';
// import 'package:flutter_tutorial/screens/screens.dart';
import 'package:flutter_tutorial/flutter_todos_keys.dart';

import '../todo_db_item.dart';
import 'package:flutter_tutorial/widgets/delete_todo_snackbar.dart';
import 'package:intl/intl.dart';
import '../time_format.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return CircularProgressIndicator(key: ArchSampleKeys.todosLoading);
        } else if (state is FilteredTodosLoaded) {
          final todoList = state.filteredTodos;
          return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, id) {
        Todo item = todoList[id];
        return Column(
          children: <Widget>[
            Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(item.id.toString()),
              onDismissed: (direction) {
                // Remove the item from the data source.
                final VisibilityFilter activeFilter = 
                  (BlocProvider.of<FilteredTodosBloc>(context).state as FilteredTodosLoaded).activeFilter;
                BlocProvider.of<TodosBloc>(context).add(
                  UpdateTodo(item.copyWith(
                    active: activeFilter == VisibilityFilter.active ? false : true)));
                Scaffold.of(context).showSnackBar(
                  DeleteTodoSnackBar(
                    todo: item,
                    onUndo: () => BlocProvider.of<TodosBloc>(context).add(
                      UpdateTodo(item.copyWith(
                        active: activeFilter == VisibilityFilter.active ? true : false))),
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
                  leading: Icon(item.type == "event" ? Icons.event : Icons.assignment),
                  trailing: DaysLeft(item.startAt),
                  title: Text(
                    item.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("test"),
                      Text(item.startAt.toLocal().toIso8601String())
                      // Text(DateFormat.MMMEd("sv_SE").add_Hm().format(item.startAt.toLocal())),
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
          
          
          
          
          // ListView.builder(
          //   key: ArchSampleKeys.todoList,
          //   itemCount: todos.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     final todo = todos[index];
          //     return TodoItem(
          //       todo: todo,
          //       onDismissed: (direction) {
          //         BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
          //         Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
          //           key: ArchSampleKeys.snackbar,
          //           todo: todo,
          //           onUndo: () =>
          //               BlocProvider.of<TodosBloc>(context).add(AddTodo(todo)),
          //           localizations: localizations,
          //         ));
          //       },
          //       onTap: () async {
          //         final removedTodo = await Navigator.of(context).push(
          //           MaterialPageRoute(builder: (_) {
          //             return DetailsScreen(id: todo.id);
          //           }),
          //         );
          //         if (removedTodo != null) {
          //           Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
          //             key: ArchSampleKeys.snackbar,
          //             todo: todo,
          //             onUndo: () => BlocProvider.of<TodosBloc>(context)
          //                 .add(AddTodo(todo)),
          //             localizations: localizations,
          //           ));
          //         }
          //       },
          //       onCheckboxChanged: (_) {
          //         BlocProvider.of<TodosBloc>(context).add(
          //           UpdateTodo(todo.copyWith(complete: !todo.complete)),
          //         );
          //       },
          //     );
          //   },
          // );
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