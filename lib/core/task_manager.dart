import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/firebase_options.dart';
import 'package:workmanager/workmanager.dart';

class Taskmanager {
  static registerPeriodicTaskTodo() {
    // Register the periodic task - Todo
    Workmanager().registerPeriodicTask(
        'syncHiveToFirebase', 'syncHiveToFirebase',
        initialDelay: const Duration(minutes: 1),
        frequency: const Duration(minutes: 15));
  }

  static Future<void> syncHiveToFirebase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ToDoModelAdapter());
    await Hive.openBox<ToDoModel>('todos');
    var todoBox = Hive.box<ToDoModel>('todos');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    var firestore = FirebaseFirestore.instance.collection('todos');

    // Sync each ToDoModel to Firestore
    for (var todo in todoBox.values) {
      await firestore.doc(todo.id).set(todo.toFirestore());
    }
  }
}
