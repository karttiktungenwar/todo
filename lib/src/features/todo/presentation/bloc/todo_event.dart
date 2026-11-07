part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class SubscribeTodosEvent extends TodoEvent {}

class TodosUpdatedEvent extends TodoEvent {
  final List<TodoItem> todos;
  const TodosUpdatedEvent(this.todos);

  @override
  List<Object?> get props => [todos];
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;

  const AddTodoEvent(this.title, this.description);

  @override
  List<Object?> get props => [title, description];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoItem item;
  const UpdateTodoEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class ToggleTodoEvent extends TodoEvent {
  final TodoItem item;
  const ToggleTodoEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
