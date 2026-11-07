import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:todo/src/app/di/injection_container.dart' as di;
import 'package:todo/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/src/features/todo/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: BlocProvider(
        create: (_) => di.sl<TodoBloc>()..add(SubscribeTodosEvent()),
        child: const TodoPage(),
      ),
    );
  }
}