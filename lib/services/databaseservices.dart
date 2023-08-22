import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();
  final dbName = "to_do.db";
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initdatabase();
    return _database!;
  }

  Future<Database> _initdatabase() async {
    log("database creation method called");
    return openDatabase(join(await getDatabasesPath(), dbName), version: 1,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            Completed INTEGER
          )
        ''');
    });
  }

  Future<int> addtask(TaskModel task) async {
    final db = await database;
    return db.insert(
      "tasks",
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> cleartable() async {
    final db = await database;
    return await db.execute("DROP TABLE tasks");
  }

  Future<int> updatetask(TaskModel task) async {
    final db = await database;
    // log(task.toJson().toString());
    return db.update(
      "tasks",
      task.toJson(),
      where: "id=?",
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletetask(TaskModel task) async {
    final db = await database;
    return db.delete("tasks", where: "id=?", whereArgs: [task.id]);
  }

  Future<List<TaskModel>?> fetchall() async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query("tasks");
    if (maps.isEmpty) {
      return null;
    } else {
      return maps.map((e) => TaskModel.fromJson(e)).toList();
    }
  }
}
