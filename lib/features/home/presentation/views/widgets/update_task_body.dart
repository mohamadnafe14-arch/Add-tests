import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/presentation/view_models/providers/to_do_provider.dart';
class UpdateTaskBody extends StatefulWidget {
  const UpdateTaskBody({super.key, required this.toDo});
  final ToDoModel toDo;
  @override
  State<UpdateTaskBody> createState() => _UpdateTaskBodyState();
}

class _UpdateTaskBodyState extends State<UpdateTaskBody> {
  final formKey = GlobalKey<FormState>();
  String? taskTitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 16),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => taskTitle = value,
            onSaved: (newValue) => taskTitle = newValue,
            decoration: InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Provider.of<ToDoProvider>(context, listen: false).updateToDo(toDo: widget.toDo, title: taskTitle);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task added successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
                GoRouter.of(context).pop();
              }
            },
            child: const Text('Update Task'),
          ),
        ],
      ),
    );
  }
}