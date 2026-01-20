import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';

final getIt = GetIt.instance;
void setupLocator() async {
  getIt.registerSingleton<Box<ToDoModel>>(Hive.box('toDoBox'));
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(toDoBox: getIt.get<Box<ToDoModel>>()),
  );
}
