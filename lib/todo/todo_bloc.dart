import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  @override
  TodoState get initialState => InitialTodoState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    // TODO: Add your event logic
  }
}
