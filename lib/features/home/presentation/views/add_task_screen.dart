import 'package:flutter/material.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/add_task_screen_body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: const AddTaskScreenBody(),
    );
  }
}
