import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';
import 'package:to_do_app/features/home/presentation/view_models/providers/to_do_provider.dart';

void main() {
  late Box<ToDoModel> toDoBox;
  late HomeRepo homeRepo;
  late ToDoProvider toDoProvider;
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Hive.init(Directory.systemTemp.path);
    Hive.registerAdapter(ToDoModelAdapter());
    toDoBox = await Hive.openBox<ToDoModel>('testToDoBox');
    homeRepo = HomeRepoImpl(toDoBox: toDoBox);
  });
  setUp(() async {
    await toDoBox.clear();
    homeRepo = HomeRepoImpl(toDoBox: toDoBox);
    toDoProvider = ToDoProvider(homeRepo: homeRepo);
  });
  tearDownAll(() async {
    await toDoBox.close();
    await Hive.deleteBoxFromDisk('testToDoBox');
  });
  test('initial state test', () {
    expect(toDoProvider.toDoList.length, 0);
    expect(toDoProvider.filter, ToDoFilter.all);
    expect(toDoProvider.homeRepo.searchQuery, '');    
  });
  test("add to do", () {
    final createdAt = DateTime.now();
    final toDo = ToDoModel(title: 'test', createdAt: createdAt);
    toDoProvider.addToDo(toDo);
    expect(toDoProvider.toDoList.length, 1);
    expect(toDoProvider.toDoList.first.title, 'test');
    expect(toDoProvider.toDoList.first.createdAt, createdAt);
    expect(toDoProvider.toDoList.first.isCompleted, false);
  });
  test("remove to do", () {
    final createdAt = DateTime.now();
    final toDo = ToDoModel(title: 'test', createdAt: createdAt);
    toDoProvider.addToDo(toDo);
    toDoProvider.removeToDo(toDo);
    expect(toDoProvider.toDoList.length, 0);
  });
  test("toggle to do status", () {
    final createdAt = DateTime.now();
    final toDo = ToDoModel(title: 'test', createdAt: createdAt);
    toDoProvider.addToDo(toDo);
    toDoProvider.toggleToDoStatus(toDo: toDo);
    expect(toDoProvider.toDoList.first.isCompleted, true);
    toDoProvider.toggleToDoStatus(toDo: toDo);
    expect(toDoProvider.toDoList.first.isCompleted, false);
  });
}
