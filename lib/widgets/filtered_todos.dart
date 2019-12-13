import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/flutter_todos_keys.dart';
import 'package:flutter_tutorial/widgets/widgets.dart';

import 'package:intl/intl.dart';
import '../time_format.dart';

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
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          // Container(
          //   width: 30,
          //   height: 75,
          //   child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [DaysLeft(todo.startAt)],)
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    todo.title,
                    // style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    course.name,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(DateFormat.MMMEd("sv_SE")
                      .add_Hm().format(todo.startAt.toLocal()),
                      style: TextStyle(fontSize: 14),
                  ),
                  // const Padding(padding: EdgeInsets.only(top: 8)),
                  // Text(
                  //   '\$${product.price}',
                  //   style: Styles.productRowItemPrice,
                  // )
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.clear_circled,
                  semanticLabel: 'Clear',
                ),
                onPressed: () {
                  final VisibilityFilter activeFilter =
                    (BlocProvider.of<FilteredTodosBloc>(context).state as FilteredTodosLoaded)
                      .activeFilter;
                  BlocProvider.of<TodosBloc>(context).add(UpdateTodo(todo.copyWith(
                    active: activeFilter == VisibilityFilter.active
                      ? false
                      : true)));
                },
              ),
              DaysLeft(todo.startAt),
            ]),
        ],
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
            Padding(
              padding: const EdgeInsets.only(
                left: 29,
                // right: 60,
              ),
              child: Container(
                height: 0.5,
                color: Colors.grey,
              ),
            ),
          ],
        );
      });
  }
}


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
          return CustomScrollView(
            semanticChildCount: todoList.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('Kommande'),
                trailing: CupertinoSwitch(
                  value: state.activeFilter == VisibilityFilter.active ? true : false,
                  onChanged: (_) => BlocProvider.of<FilteredTodosBloc>(context).add(
                    UpdateFilter(state.activeFilter == VisibilityFilter.active
                      ? VisibilityFilter.inactive 
                      : VisibilityFilter.active)),
                ),
              ),
              SliverSafeArea(      // BEGINNING OF NEW CONTENT
               top: false,
               minimum: const EdgeInsets.only(top: 8),
               sliver: SliverList(
                 delegate: SliverChildBuilderDelegate(
                   (context, index) {
                     if (index < todoList.length) {
                       return TodoRowItem(
                         index: index,
                         todo: todoList[index],
                         course: courseList.firstWhere((course) => todoList[index].courseId == course.id),
                         lastItem: index == todoList.length - 1,
                       );
                     }
                     return null;
                   },
                 ),
               ),
             )
            ],
          );
          ListView.builder(
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
                                      // color: Colors.white,
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
