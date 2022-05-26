import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DatabaseHelper {
  Future<Database> _getDatabase() async {
    return openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, isDone BOOLEAN)',
        );
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isDone: maps[i]['isDone'] == 0 ? false : true,
      );
    });
  }

  Future<int> getLastId() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.isEmpty ? 0 : maps.last['id'];
  }

  Future<void> addTask(Task task) async {
    final Database db = await _getDatabase();
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final Database db = await _getDatabase();
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(Task task) async {
    final Database db = await _getDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
  }
}
