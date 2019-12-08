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
    print("init Database");
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "todo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT)");
          await db.execute("CREATE TABLE assignments(id TEXT PRIMARY KEY)");
        });
  }

  resetDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "todo.db");
    await deleteDatabase(path);
  }

  Future<void> hideTodoItem(Todo todo) async {
    final Database db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Todo> getTodo(int id) async {
    final Database db = await database;
    var res = await db.query("todos", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : null;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    var res = await db.query("todos");
    List<Todo> list =
    res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
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

