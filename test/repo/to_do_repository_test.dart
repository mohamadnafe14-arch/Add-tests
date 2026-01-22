import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';

void main() {
  late Box<ToDoModel> box;
  late HomeRepo homeRepo;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Hive.init(Directory.systemTemp.path);
    Hive.registerAdapter(ToDoModelAdapter());
    box = await Hive.openBox<ToDoModel>('testToDoBox');
  });

  setUp(() async {
    await box.clear();
    homeRepo = HomeRepoImpl(toDoBox: box);
  });

  tearDownAll(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('testToDoBox');
  });

  test('add to do', () {
    final createdAt = DateTime.now();
    final toDo = ToDoModel(title: 'test', createdAt: createdAt);

    homeRepo.addToDo(toDo);
    final toDos = homeRepo.getAllToDos();

    expect(toDos.length, 1);
    expect(toDos.first.title, 'test');
    expect(toDos.first.isCompleted, false);
    expect(toDos.first.createdAt, createdAt);
  });

  test('update to do', () {
    final toDo = ToDoModel(title: 'test', createdAt: DateTime.now());
    homeRepo.addToDo(toDo);

    homeRepo.updateToDo(toDo: toDo, title: 'test2');
    final toDos = homeRepo.getAllToDos();

    expect(toDos.first.title, 'test2');
  });

  test('remove to do', () {
    final toDo = ToDoModel(title: 'test', createdAt: DateTime.now());
    homeRepo.addToDo(toDo);

    homeRepo.removeToDo(toDo);
    final toDos = homeRepo.getAllToDos();

    expect(toDos.isEmpty, true);
  });

  test('toggle to do', () {
    final toDo = ToDoModel(title: 'test', createdAt: DateTime.now());
    homeRepo.addToDo(toDo);

    homeRepo.toggleToDoStatus(toDo: toDo);
    final toDos = homeRepo.getAllToDos();

    expect(toDos.first.isCompleted, true);
  });
}
