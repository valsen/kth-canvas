import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_tutorial/data/models/models.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetLocalTodos extends TodoEvent {}

class GetActiveTodos extends TodoEvent {}

class ResetTodoList extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todoItem;

  const AddTodo(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}

class UpdateTodo extends TodoEvent {
  final Todo todoItem;

  const UpdateTodo(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}