import 'package:flutter/cupertino.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(TodoRepository())
              ..add(GetLocalTodos())
              ..add(GetActiveTodos());
          },
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: CanvasApp(),
    ),
  );
}

class CanvasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
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
            onSave: (todo) {
              BlocProvider.of<TodosBloc>(context).add(
                AddTodo(todo));
              // BlocProvider.of<FilteredTodosBloc>(context).add(
              //   UpdateTodos((BlocProvider.of<TodosBloc>(context).state as TodosLoaded)
              //     .todoList));
            },
            isEditing: false,
          );        
        }
      },
    );
  }
}