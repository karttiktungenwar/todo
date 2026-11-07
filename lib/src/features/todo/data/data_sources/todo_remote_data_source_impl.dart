import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/src/features/todo/data/models/todo_item_model.dart';
import 'todo_remote_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  TodoRemoteDataSourceImpl({required this.firestore, required this.auth});

  CollectionReference _getTodoCollection() {
    final uid = auth.currentUser?.uid ?? 'anonymous_user';
    return firestore.collection('users').doc(uid).collection('todos');
  }

  @override
  Stream<List<TodoItemModel>> getTodosStream() {
    return _getTodoCollection()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => TodoItemModel.fromSnapshot(doc)).toList());
  }

  @override
  Future<void> addTodo(TodoItemModel item) async {
    await _getTodoCollection().doc(item.id).set(item.toDocument());
  }

  @override
  Future<void> updateTodo(TodoItemModel item) async {
    await _getTodoCollection().doc(item.id).update(item.toDocument());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _getTodoCollection().doc(id).delete();
  }
}