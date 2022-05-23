import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo/db/database_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();
  static Database? _database;

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // / If database don't exists, create one
    _database = await initDB();
    return _database;
  }

  Future<dynamic> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'toDo.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ToDo('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'title TEXT DEFAULT "",'
          'description TEXT DEFAULT ""'
          ')');
    });
  }

  Future<List<ToDoModel>> addToDoData(
    String title,
    String description,
  ) async {
    final db = await database;
    final res = await db!.rawQuery(
        "INSERT INTO ToDo(title, description) VALUES(?, ?)",
        [title, description]);

    List<ToDoModel> list =
        res.isNotEmpty ? res.map((c) => ToDoModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ToDoModel>> getToDoData() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM ToDo");

    List<ToDoModel> list =
        res.isNotEmpty ? res.map((c) => ToDoModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ToDoModel>> updateToDoData(
      String id, String title, String description) async {
    final db = await database;
    final res = await db!.rawQuery(
        "Update ToDo SET title=?, description=? Where id=?",
        [title, description, id]);

    List<ToDoModel> list =
        res.isNotEmpty ? res.map((c) => ToDoModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ToDoModel>> deleteToDoData(int id) async {
    final db = await database;
    final res = await db!.rawQuery("DELETE FROM ToDo WHERE id = ?", [id]);

    List<ToDoModel> list =
        res.isNotEmpty ? res.map((c) => ToDoModel.fromJson(c)).toList() : [];
    return list;
  }
}
