part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  const TodoInitial();
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  const TodoLoading();
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<UpcomingEvent> todoList;
  const TodoLoaded(this.todoList);
  @override
  List<Object> get props => [todoList];
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
  @override
  List<Object> get props => [message];
}