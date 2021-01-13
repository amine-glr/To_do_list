import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task_item.dart';

class databaseHelper {
  static final databaseHelper instance = databaseHelper._instance();
  static Database _db;

  databaseHelper._instance();

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colisDone = 'isDone';


  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,  $colisDone INTEGER, $colTitle TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskTable);
    return result;
  }

  Future<List<TaskItem>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<TaskItem> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(TaskItem.fromMap(taskMap));
    });

    return taskList;
  }

  Future<int> insertTask(TaskItem task) async {
    Database db = await this.db;
    final int result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(TaskItem task) async {
    Database db = await this.db;
    final int result = await db.update(taskTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result =
    await db.delete(taskTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}