import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';

class TodoItemModel extends TodoItem {
  const TodoItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
  });

  factory TodoItemModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoItemModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory TodoItemModel.fromEntity(TodoItem item) {
    return TodoItemModel(
      id: item.id,
      title: item.title,
      description: item.description,
      isCompleted: item.isCompleted,
      createdAt: item.createdAt,
    );
  }
}