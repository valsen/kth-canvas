import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_tutorial/data/models/upcoming_events_model.dart';
import 'package:flutter_tutorial/data/canvas_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../todo_db_item.dart';
import '../../data/database.dart';


part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CanvasRepository canvasRepository;

  TodoBloc(this.canvasRepository);

  @override
  TodoState get initialState => TodoInitial();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    yield TodoLoading();
    if (event is GetTodoList) {
      try {
        final todoList = await canvasRepository.fetchTodoList();
        yield TodoLoaded(todoList);
      } on NetworkError {
        yield TodoError("Couldn't fetch todo list");
      }
    } else if (event is HideTodoItem) {
      try {
        final todoList = await canvasRepository.hideTodoItem(event.todoItem);
        yield TodoLoaded(todoList);
      } on DatabaseError {
        yield TodoError("Couldn't hide todo item");
      }
    }
  }
}
