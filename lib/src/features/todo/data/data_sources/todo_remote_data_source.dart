import 'package:todo/src/features/todo/data/models/todo_item_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoItemModel>> getTodosStream();
  Future<void> addTodo(TodoItemModel item);
  Future<void> updateTodo(TodoItemModel item);
  Future<void> deleteTodo(String id);
}