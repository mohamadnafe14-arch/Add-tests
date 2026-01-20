import 'package:go_router/go_router.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/presentation/views/add_task_view.dart';
import 'package:to_do_app/features/home/presentation/views/home_view.dart';
import 'package:to_do_app/features/home/presentation/views/update_task_view.dart';
import 'package:to_do_app/features/splash/presentation/views/splash_screen.dart';

class RoutePages {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String addTaskRoute = '/addTask';
  static const String updateTaskRoute = '/updateTask';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SpalshScreen(),
      ),
      GoRoute(path: homeRoute, builder: (context, state) => const HomeView()),
      GoRoute(
        path: addTaskRoute,
        builder: (context, state) => const AddTaskView(),
      ),
      GoRoute(
        path: updateTaskRoute,
        builder: (context, state){
          final toDoModel = state.extra as ToDoModel;
          return UpdateTaskView(toDoModel: toDoModel);
        },
      ),
    ],
  );
}
