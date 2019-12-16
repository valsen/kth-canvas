import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/screens/add_edit_screen.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
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
          final VisibilityFilter activeFilter = 
            (BlocProvider.of<FilteredTodosBloc>(context)
              .state as FilteredTodosLoaded)
              .activeFilter;
          return CustomScrollView(
            semanticChildCount: todoList.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('Kommande'),
                trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: <Widget>[
                  CupertinoSegmentedControl(
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                  CupertinoButton(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(CupertinoIcons.add),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            onSave: (todo) {
                              BlocProvider.of<TodosBloc>(context).add(
                                AddTodo(todo),
                              );
                            },
                            isEditing: false,
                          );
                        },
                      ));
                    }
                      )
                ]),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  BlocProvider.of<TodosBloc>(context).add(GetActiveTodos());
                  return Future.delayed(Duration(seconds: 3));
                }
              ),
              SliverSafeArea(      // BEGINNING OF MAIN CONTENT
               top: false,
               minimum: const EdgeInsets.only(top: 8),
               sliver: SliverList(
                 delegate: SliverChildBuilderDelegate(
                   (context, index) {
                     if (index < todoList.length) {
                       final Todo todo = todoList[index];
                       return 
                       Dismissible(
                         direction: DismissDirection.endToStart,
                         background: swipeBackground(activeFilter),
                         key: Key(todo.id.toString()),
                         onDismissed: (direction) {
                           BlocProvider.of<TodosBloc>(context).add(UpdateTodo(
                                todo.copyWith(
                                    active: activeFilter == VisibilityFilter.active
                                        ? false
                                        : true)));
                            // Scaffold.of(context).showSnackBar(
                            //   DeleteTodoSnackBar(
                            //       todo: todo,
                            //       onUndo: () => BlocProvider.of<TodosBloc>(context)
                            //           .add(UpdateTodo(todo.copyWith(
                            //               active: activeFilter ==
                            //                       VisibilityFilter.active
                            //                   ? true
                            //                   : false))),
                            //       key: Key(todo.id.toString())),
                            // );
                        },
                        child: TodoRowItem(
                          index: index,
                          todo: todoList[index],
                          course: courseList.firstWhere((course) => todoList[index].courseId == course.id),
                          lastItem: index == todoList.length - 1,
                        ),
                       );
                     }
                     return null;
                   },
                 ),
               ),
             )
            ],
          );
        } else {
          return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
