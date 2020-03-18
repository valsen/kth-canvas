import 'dart:io';
import 'dart:convert';

import 'package:flutter_tutorial/data/database.dart';
import 'package:flutter_tutorial/data/models/models.dart';

import 'package:http/http.dart' as http;

abstract class CanvasRepository {
  Future<List<UpcomingEvent>> fetchTodoList();
  Future<List<CanvasCourse>> fetchCourses();
  // Future<List<CourseAssignment>> fetchCourseAssignments(int id);
  Future<List<CustomColor>> getCustomColors();
  Future<List<CalendarAssignment>> fetchCalendarAssignments(int id);
  Future<Map<String, dynamic>> fetchCourseColor(int id);
  Future<void> updateTodoItem(Todo todoItem);
  Future<void> insertTodoItems(List<Todo> todos);
  Future<void> insertCourses(List<CanvasCourse> courses);
  // Future<void> undoHideTodoItem(Todo todoItem);
}

class TodoRepository implements CanvasRepository {
  String token =
      "YOUR CANVAS ACCESS TOKEN HERE";

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

  // @override
  // Future<List<CourseAssignment>> fetchCourseAssignments(id) async {
  //   String url =
  //       "https://kth.instructure.com/api/v1/users/self/upcoming_events";
  //   var res = await http.get(url, headers: {
  //     'Authorization': 'Bearer $token',
  //   });

  //   if (res.statusCode == 200) {
  //     // If server returns an OK response, parse the JSON.
  //     return assignmentsFromJson(res.body);
  //   } else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load courses');
  //   }
  // }

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
      // If server returns an OK response, parse the JSON.
      return calendarAssignmentsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load calendar assignments');
    }
  }

  @override
  Future<List<CanvasCourse>> fetchCourses() async {
    String url =
        "https://kth.instructure.com/api/v1/users/self/favorites/courses";
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
  Future<void> insertCourses(List<CanvasCourse> courses) async {
    await DBProvider.db.insertCourses(courses);
  }

  @override
  Future<void> updateTodoItem(Todo todoItem) async {
    await DBProvider.db.updateTodoItem(todoItem);
  }

  @override
  Future<void> insertTodoItems(List<Todo> todos) async {
    for (var todo in todos) {
      print('\n');
      print(todo.toMap());
    }
    await DBProvider.db.insertTodoItems(todos);
  }

  @override
  Future<List<CustomColor>> getCustomColors() async {
    return await DBProvider.db.getCustomColors();
  }

  @override
  Future<Map<String, dynamic>> fetchCourseColor(int id) async {
    String url =
        "https://kth.instructure.com/api/v1/users/self/colors/course_$id";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }
}

class DatabaseError extends Error {}

class NetworkError extends Error {}
