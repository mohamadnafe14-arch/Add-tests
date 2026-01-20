import 'package:flutter/material.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/Update_task_body.dart';

class UpdateTaskView extends StatelessWidget {
  const UpdateTaskView({super.key, required this.toDoModel});
  final ToDoModel toDoModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: UpdateTaskBody(
          toDo: toDoModel,
        ),
      ),
    );
  }
}