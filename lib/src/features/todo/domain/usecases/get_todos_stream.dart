import 'package:dartz/dartz.dart';
import 'package:todo/src/core/error/failures.dart';
import 'package:todo/src/core/usecase/usecase.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';
import 'package:todo/src/features/todo/domain/repositories/todo_repository.dart';

class GetTodosStream implements StreamUseCase<List<TodoItem>, NoParams> {
  final TodoRepository repository;
  GetTodosStream(this.repository);

  @override
  Stream<Either<Failure, List<TodoItem>>> call(NoParams params) {
    return repository.getTodosStream();
  }
}