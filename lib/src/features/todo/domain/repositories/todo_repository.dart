import 'package:dartz/dartz.dart';
import 'package:todo/src/core/error/failures.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';


abstract class TodoRepository {
  Stream<Either<Failure, List<TodoItem>>> getTodosStream();
  Future<Either<Failure, void>> addTodo(TodoItem item);
  Future<Either<Failure, void>> updateTodo(TodoItem item);
  Future<Either<Failure, void>> deleteTodo(String id);
}