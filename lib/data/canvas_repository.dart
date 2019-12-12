import 'dart:io';

import 'package:flutter_tutorial/bloc/todo/todo_bloc.dart';
import 'package:flutter_tutorial/data/database.dart';
import 'package:flutter_tutorial/data/models/course_assignments_model.dart';
import 'package:flutter_tutorial/data/models/courses_model.dart';

import '../todo_db_item.dart';
import 'models/calendar_assignment_model.dart';
import 'models/upcoming_events_model.dart';
import 'package:http/http.dart' as http;

abstract class CanvasRepository {
  Future<List<UpcomingEvent>> fetchTodoList();
  Future<List<CanvasCourse>> fetchCourses();
  Future<List<CourseAssignment>> fetchCourseAssignments(int id);
  Future<List<CalendarAssignment>> fetchCalendarAssignments(int id);
  Future<void> updateTodoItem(Todo todoItem);
  Future<void> insertTodoItems(List<Todo> todos);
  // Future<void> undoHideTodoItem(Todo todoItem);
}

class TodoRepository implements CanvasRepository {
  String token =
      "8779~KzUQiD6KASsiotpodfWzwBu1xCI8nCbkNgUgRslXKQl5sI7o4IKQQFSVbGiPZc1E";

  @override
  Future<List<UpcomingEvent>> fetchTodoList() async {
    String url =
        "https://kth.instructure.com/api/v1/users/self/upcoming_events";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return upcomingEventsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }
  @override
  Future<List<CourseAssignment>> fetchCourseAssignments(id) async {
    String url =
        "https://kth.instructure.com/api/v1/users/self/upcoming_events";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return assignmentsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }

  @override
  Future<List<CalendarAssignment>> fetchCalendarAssignments(id) async {
    Uri _url = Uri.https(
      'kth.instructure.com',
      '/api/v1/calendar_events',
      {
        'all_events': '1',
        'context_codes[]': 'course_$id',
        'type': 'assignment',
        'excludes[]': 'description',
        'per_page': '100',
      },
    );

    var res = await http.get(_url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (res.statusCode == 200) {
//      print(res.body);
      // If server returns an OK response, parse the JSON.
      return calendarAssignmentsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load calendar assignments');
    }
  }

  @override
  Future<List<CanvasCourse>> fetchCourses() async {
    String url = "https://kth.instructure.com/api/v1/users/self/favorites/courses";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return canvasCoursesFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }
  
  @override
  Future<void> updateTodoItem(Todo todoItem) async {
    await DBProvider.db.updateTodoItem(todoItem);
  }

  @override
  Future<void> insertTodoItems(List<Todo> todos) async {
    await DBProvider.db.insertTodoItems(todos);
  }

  // @override
  // Future<void> undoHideTodoItem(Todo todoItem) async {
  //   await DBProvider.db.undoHideTodoItem(todoItem);
  // }
}

class DatabaseError extends Error {}
class NetworkError extends Error {}
