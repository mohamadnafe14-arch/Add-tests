import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';
import 'package:to_do_app/features/home/presentation/view_models/providers/to_do_provider.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/home_view_body.dart';

void main() {
  late ToDoModel toDoModel;
  late ToDoProvider toDoProvider;
  late Box<ToDoModel> toDoBox;
  late HomeRepo homeRepo;
  setUpAll(() async {
    final testDir = Directory(
      path.join(
        Directory.systemTemp.path,
        'hive_test_${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    await testDir.create(recursive: true);

    Hive.init(testDir.path);
    Hive.registerAdapter(ToDoModelAdapter());
    toDoBox = await Hive.openBox<ToDoModel>('testToDoBox');

    addTearDown(() async {
      await toDoBox.clear();
      await toDoBox.close();
      await Hive.deleteBoxFromDisk('testToDoBox');
    });
  });

  setUp(() async {
    await toDoBox.clear();
    toDoModel = ToDoModel(title: 'test', createdAt: DateTime.now());
    homeRepo = HomeRepoImpl(toDoBox: toDoBox);
    toDoProvider = ToDoProvider(homeRepo: homeRepo);
  });
  testWidgets('list is shown', (tester) async {
    toDoProvider.addToDo(toDoModel);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(home: Scaffold(body: HomeViewBody())),
        ),
      ),
    );

    await tester.pumpAndSettle(); // مهم جدًا عشان الـ UI يتحدث

    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('list is empty', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(home: Scaffold(body: HomeViewBody())),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('test'), findsNothing);
  });

  testWidgets('search query', (tester) async {
    toDoProvider.addToDo(toDoModel);
    toDoProvider.setSearchQuery('test');

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(home: Scaffold(body: HomeViewBody())),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('test'), findsOneWidget);
  });
}
