// lib/data/models/todo_model.dart
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime createdAt;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  // From Firestore
  factory ToDoModel.fromFirestore(Map<String, dynamic> firestore) {
    return ToDoModel(
      id: firestore['id'],
      title: firestore['title'],
      description: firestore['description'],
      isCompleted: firestore['isCompleted'],
      createdAt: firestore['createdAt'].toDate(),
    );
  }

  // To Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
    };
  }
}
