import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/src/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:todo/src/features/todo/data/data_sources/todo_remote_data_source_impl.dart';
import 'package:todo/src/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo/src/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo/src/features/todo/domain/usecases/add_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/get_todos_stream.dart';
import 'package:todo/src/features/todo/domain/usecases/toggle_todo.dart';
import 'package:todo/src/features/todo/domain/usecases/update_todo.dart';
import 'package:todo/src/features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Presentation: Bloc
  sl.registerFactory(() => TodoBloc(
    getTodosStream: sl(),
    addTodo: sl(),
    updateTodo: sl(),
    toggleTodo: sl(),
    deleteTodo: sl(),
  ));

  // Domain: Use Cases
  sl.registerLazySingleton(() => GetTodosStream(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Domain & Data: Repository
  sl.registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data: Datasource
  sl.registerLazySingleton<TodoRemoteDataSource>(
        () => TodoRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );

  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
