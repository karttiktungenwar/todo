import 'package:dartz/dartz.dart';
import 'package:todo/src/core/error/failures.dart';
import 'package:todo/src/core/usecase/usecase.dart';
import 'package:todo/src/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;
  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteTodo(id);
  }
}