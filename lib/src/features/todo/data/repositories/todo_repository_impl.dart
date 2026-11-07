import 'package:dartz/dartz.dart';
import 'package:todo/src/core/error/failures.dart';
import 'package:todo/src/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:todo/src/features/todo/data/models/todo_item_model.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';
import 'package:todo/src/features/todo/domain/repositories/todo_repository.dart';


class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<TodoItem>>> getTodosStream() {
    return remoteDataSource
        .getTodosStream()
        .map<Either<Failure, List<TodoItem>>>((todos) => Right(todos))
        .handleError((error) => Left(ServerFailure(error.toString())));
  }

  @override
  Future<Either<Failure, void>> addTodo(TodoItem item) async {
    try {
      final model = TodoItemModel.fromEntity(item);
      await remoteDataSource.addTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoItem item) async {
    try {
      final model = TodoItemModel.fromEntity(item);
      await remoteDataSource.updateTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await remoteDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}