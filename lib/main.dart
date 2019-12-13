import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/data/canvas_repository.dart';
import 'package:flutter_tutorial/screens/home_screen.dart';
import 'package:flutter_tutorial/screens/add_edit_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      create: (context) {
        return TodosBloc(TodoRepository())
          ..add(GetLocalTodos())
          ..add(GetActiveTodos());
      },
      child: CanvasApp(),
    ),
  );
}

class CanvasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Canvas",
      routes: {
        '/': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) => FilteredTodosBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
        'addTodo': (context) {
          return AddEditScreen(
            // key: ArchSampleKeys.addTodoScreen,
            onSave: (todo) {
              BlocProvider.of<TodosBloc>(context).add(
                AddTodo(todo),
              );
            },
            isEditing: false,
          );
        }
      },
    );
  }
}