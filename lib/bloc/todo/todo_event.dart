part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetTodoList extends TodoEvent {
  final List<Object> hiddenItems;

  const GetTodoList(this.hiddenItems);

  @override
  List<Object> get props => [hiddenItems];
}

class HideTodoItem extends TodoEvent {
  final Todo todoItem;

  const HideTodoItem(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}