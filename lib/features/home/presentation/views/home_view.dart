import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: HomeViewBody(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          GoRouter.of(context).push('/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
