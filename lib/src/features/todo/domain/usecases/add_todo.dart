import 'package:dartz/dartz.dart';
import 'package:todo/src/core/error/failures.dart';
import 'package:todo/src/core/usecase/usecase.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';
import 'package:todo/src/features/todo/domain/repositories/todo_repository.dart';

class AddTodo implements UseCase<void, TodoItem> {
  final TodoRepository repository;
  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(TodoItem params) {
    return repository.addTodo(params);
  }
}