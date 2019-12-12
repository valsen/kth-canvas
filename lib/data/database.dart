import 'package:flutter_tutorial/data/models/calendar_assignment_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../todo_db_item.dart';
import 'models/calendar_assignment_db_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
   DBProvider.db.deleteLocalDatabase();
    print("initializing Database");
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "todo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, type TEXT, start_at TEXT, course_id INTEGER, active INTEGER)");
          await db.execute("CREATE TABLE assignments(id STRING PRIMARY KEY)");
        });
  }

  Future<void> resetTodos() async {
    print("resetting todos");
    final Database db = await database;
    await db.execute("DELETE FROM todos");
  }

  Future<void> resetAssignments() async {
    print("resetting assignments");
    final Database db = await database;
    await db.execute("DELETE FROM assignments");
  }

  Future<void> deleteLocalDatabase() async {
    print("deleting database");
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "todo.db");
    await deleteDatabase(path);
  }

  Future<void> insertTodoItems(List<Todo> todos) async {
    final Database db = await database;
    for (Todo todo in todos) {
      await db.insert(
        "todos",
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> updateTodoItem(Todo todo) async {
    final Database db = await database;
    print(todo.toMap());
    await db.insert(
      "todos",
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Future<void> undoHideTodoItem(Todo todo) async {
  //   final Database db = await database;
  //   await db.insert(
  //     "todos",
  //     todo.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Future<Todo> getTodo(dynamic id) async {
    final Database db = await database;
    var res = await db.query("todos", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromLocalMap(res.first) : null;
  }


  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    var res = await db.query("todos");
    List<Todo> list =
    res.isNotEmpty ? res.map((c) => Todo.fromLocalMap(c)).toList() : [];
    return list;
  }

  Future<void> insertAssignment(DBAssignment assignment) async {
    final Database db = await database;
    await db.insert(
      'assignments',
      assignment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DBAssignment> getAssignment(String id) async {
    final Database db = await database;
    var res = await db.query("assignments", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? DBAssignment.fromMap(res.first) : null;
  }


}

