import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter_tutorial/data/models/models.dart';
import 'package:flutter_tutorial/data/canvas_repository.dart';
import 'package:flutter_tutorial/data/database.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';

class TodosBloc extends Bloc<TodoEvent, TodoState> {
  final CanvasRepository canvasRepository;
  final List<int> hiddenIds = [];

  TodosBloc(this.canvasRepository);

  @override
  TodoState get initialState => TodosLoading();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is GetLocalTodos) {
      yield* _mapGetLocalTodosToState();
    } else if (event is GetActiveTodos) {
      yield* _mapLoadTodosToState();
    } else if(event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapHideTodoToState(event);
    } else if (event is ResetTodoList) {
      yield* _mapResetTodosToState();
    }
  }

  Stream<TodoState> _mapGetLocalTodosToState() async* {
    try {
      final List<Todo> localItems = await DBProvider.db.getAllTodos();
      final List<CanvasCourse> courseList = await DBProvider.db.getAllCourses();
      courseList.sort((a,b) => a.name.compareTo(b.name));

      yield TodosLoaded(localItems, courseList);
    } catch (err) {
      yield TodosLoading();
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    try {
      final List<UpcomingEvent> todoListResponse =
          await canvasRepository.fetchTodoList();
      Iterable<Todo> todoList = todoListResponse
          .map((upcoming) => Todo.fromUpcomingMap(
                {
                  "id": upcoming.id,
                  "title": upcoming.title,
                  "start_at": upcoming.startAt,
                  "type": upcoming.type,
                  "context_code": upcoming.contextCode
                },
              ))
          .toList();

      final List<CanvasCourse> courseList = await canvasRepository.fetchCourses();
      courseList.sort((a,b) => a.name.compareTo(b.name));

      for (var course in courseList) {
        Map<String, dynamic> color = await canvasRepository.fetchCourseColor(course.id);
        course.color = color["hexcode"];
      }

      todoList = await _combinedTodoList(todoList, courseList);

      List<Todo> localItems = await DBProvider.db.getAllTodos();

      final newItems = todoList
          .where((todo1) =>
              !localItems.any((todo2) => todo1.id == todo2.id) &&
              todo1.startAt.isAfter(DateTime.now()))
          .toList();
      localItems.addAll(newItems);

      yield TodosLoaded(localItems, courseList);

      canvasRepository.insertTodoItems(newItems);
      canvasRepository.insertCourses(courseList);
    } on NetworkError {
      yield TodosError("Error fetching todos or courses");
    } catch (err) {
      print(err);
      yield TodosLoading();
    }
  }

  Stream<TodoState> _mapHideTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos =
          (state as TodosLoaded).todoList.map((todo) {
        return todo.id == event.todoItem.id ? event.todoItem : todo;
      }).toList();
      yield TodosLoaded(updatedTodos, (state as TodosLoaded).courseList);
      canvasRepository.updateTodoItem(event.todoItem);
    }
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    print("UTANFOR");
    if (state is TodosLoaded) {
      print("INNANFOR");
      final List<Todo> updatedTodos =
          (state as TodosLoaded).todoList..add(event.todoItem);

      yield TodosLoaded(updatedTodos, (state as TodosLoaded).courseList);
      DBProvider.db.updateTodoItem(event.todoItem);
    }
  }

  Stream<TodoState> _mapResetTodosToState() async* {
    if (state is TodosLoaded) {
      final List<Todo> hidden = await DBProvider.db.getAllTodos();
      final List<Todo> updatedTodoList =
          List.from((state as TodosLoaded).todoList)
            ..addAll(hidden)
            ..sort((a, b) => a.startAt.compareTo(b.startAt));
      yield TodosLoaded(updatedTodoList, (state as TodosLoaded).courseList);
      DBProvider.db.resetTodos();
    }
  }

  Future<List<Todo>> _combinedTodoList(
      List<Todo> todoList, List<CanvasCourse> courseList) async {
    await Future.forEach(courseList, (course) async {
      final List<CalendarAssignment> assignments =
          await canvasRepository.fetchCalendarAssignments(course.id);
      todoList.addAll(assignments
          .map(
            (assignment) => Todo.fromAssignmentMap(
              {
                "id": assignment.assignment.id,
                "title": assignment.title,
                "due_at": assignment.assignment.dueAt,
                "type": "assignment",
                "course_id": course.id
              },
            ),
          )
          .where(
              (assignment) => !todoList.any((todo) => assignment.id == todo.id))
          .toList());
    });
    return todoList;
  }
}
