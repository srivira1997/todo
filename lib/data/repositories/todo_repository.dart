import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/todo_model.dart';

class ToDoRepository {
  static const boxName = "todos";
  static Box<ToDoModel> box = Hive.box<ToDoModel>(boxName);

  /// Add new Task
  static Future<void> addTask({required ToDoModel task}) async {
    await box.put(task.id, task);
  }

  /// Show task
  Future<ToDoModel?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  Future<void> updateTask({required ToDoModel task}) async {
    await task.save();
  }

  /// Delete task
  Future<void> dalateTask({required ToDoModel task}) async {
    await task.delete();
  }

  static Future<List<ToDoModel>> getToDos() async {
    // Fetch from Hive first
    List<ToDoModel> localToDos = box.values.toList();
    return localToDos;
  }

  ValueListenable<Box<ToDoModel>> listenToTask() {
    return box.listenable();
  }
}
