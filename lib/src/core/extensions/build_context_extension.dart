import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/todo/domain/entities/todo_item.dart';
import 'package:todo/src/features/todo/presentation/bloc/todo_bloc.dart';

extension BuildContextExtension on BuildContext {

  void showAddDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: this,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Add Todo/Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                read<TodoBloc>().add(
                  AddTodoEvent(
                    titleController.text.trim(),
                    descController.text.trim(),
                  ),
                );
                Navigator.pop(dialogCtx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void showEditDialog(TodoItem item) {
    final titleController = TextEditingController(text: item.title);
    final descController = TextEditingController(text: item.description);

    showDialog(
      context: this,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Edit Todo/Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                final updatedItem = item.copyWith(
                  title: titleController.text.trim(),
                  description: descController.text.trim(),
                );
                read<TodoBloc>().add(UpdateTodoEvent(updatedItem));
                Navigator.pop(dialogCtx);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
