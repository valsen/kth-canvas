import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'todo.dart';
import '../../todo_db_item.dart';
import '../../data/models/courses_model.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();
}

class TodosInitial extends TodoState {
  const TodosInitial();
  @override
  List<Object> get props => [];
}

class TodosLoading extends TodoState {
  const TodosLoading();
  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodoState {
  final List<Todo> todoList;
  final List<CanvasCourse> courseList;
  const TodosLoaded(this.todoList, this.courseList);

  @override
  List<Object> get props => [todoList, courseList];

  @override
  String toString() => 'TodosLoaded { todos: $todoList }';
}

class TodosError extends TodoState {
  final String message;
  const TodosError(this.message);
  @override
  List<Object> get props => [message];
}