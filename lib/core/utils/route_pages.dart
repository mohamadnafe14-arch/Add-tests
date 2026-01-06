import 'package:go_router/go_router.dart';
import 'package:to_do_app/features/home/presentation/views/add_task_screen.dart';
import 'package:to_do_app/features/home/presentation/views/home_view.dart';
import 'package:to_do_app/features/splash/presentation/views/splash_screen.dart';

class RoutePages {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String addTaskRoute = '/addTask';
 static final router=GoRouter(routes: [
    GoRoute(path: splashRoute, builder: (context, state) => const SpalshScreen()),
    GoRoute(path: homeRoute, builder: (context, state) => const HomeView()),
    GoRoute(path: addTaskRoute, builder: (context, state) => const AddTaskScreen()),
  ]);
}