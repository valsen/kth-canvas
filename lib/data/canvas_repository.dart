import 'package:flutter_tutorial/data/database.dart';

import '../todo_db_item.dart';
import 'models/upcoming_events_model.dart';
import 'package:http/http.dart' as http;

abstract class CanvasRepository {
  Future<List<UpcomingEvent>> fetchTodoList();
  Future<List<UpcomingEvent>> hideTodoItem(Todo todoItem);
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
  Future<List<UpcomingEvent>> hideTodoItem(Todo todoItem) async {
    await DBProvider.db.hideTodoItem(todoItem);
    return await fetchTodoList();
  }
}

class DatabaseError extends Error {}
class NetworkError extends Error {}
