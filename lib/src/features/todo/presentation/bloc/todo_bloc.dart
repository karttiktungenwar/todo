import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/core/usecase/usecase.dart';
import 'package:uuid/uuid.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';
import 'package:todo/src/features/todo/domain/usecases/add_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/get_todos_stream.dart';
import 'package:todo/src/features/todo/domain/usecases/toggle_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/update_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosStream getTodosStream;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final ToggleTodo toggleTodo;
  final DeleteTodo deleteTodo;
  StreamSubscription? _todosSubscription;

  TodoBloc({
    required this.getTodosStream,
    required this.addTodo,
    required this.updateTodo,
    required this.toggleTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<SubscribeTodosEvent>(_onSubscribeTodos);
    on<TodosUpdatedEvent>(_onTodosUpdated);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onSubscribeTodos(SubscribeTodosEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    _todosSubscription?.cancel();
    _todosSubscription = getTodosStream(NoParams()).listen((result) {
      result.fold(
            (failure) => add(TodosUpdatedEvent(const [])),
            (todos) => add(TodosUpdatedEvent(todos)),
      );
    });
  }

  void _onTodosUpdated(TodosUpdatedEvent event, Emitter<TodoState> emit) {
    emit(TodoLoaded(event.todos));
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final newItem = TodoItem(
      id: const Uuid().v4(),
      title: event.title,
      description: event.description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    await addTodo(newItem);
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    await updateTodo(event.item);
  }

  Future<void> _onToggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) async {
    await toggleTodo(event.item);
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    await deleteTodo(event.id);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
