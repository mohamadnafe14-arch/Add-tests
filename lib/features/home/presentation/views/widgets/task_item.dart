import 'package:flutter/material.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.provider, required this.index});
  final ToDoProvider provider;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: provider.toDoList[index].isCompleted,
        onChanged: (value) {
          provider.toggleToDoStatus(toDo: provider.toDoList[index]);
        },
      ),
      title: Text(
        provider.toDoList[index].title,
        style: TextStyle(
          decoration: provider.toDoList[index].isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          provider.removeToDo(provider.toDoList[index]);
        },
      ),
    );
  }
}