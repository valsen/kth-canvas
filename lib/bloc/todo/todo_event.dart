import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


import 'todo.dart';
import '../../todo_db_item.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetActiveTodos extends TodoEvent {}

class GetInactiveTodos extends TodoEvent {}

class ResetTodoList extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final Todo todoItem;

  const UpdateTodo(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}