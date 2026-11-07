import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/core/extensions/build_context_extension.dart';
import 'package:todo/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/src/features/todo/presentation/widgets/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cloud Notes & Todos')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No notes or todos yet. Add one!'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.1,
              ),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final item = state.todos[index];
                return TodoCard(item: item);
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.showAddDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
