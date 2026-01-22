import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';
import 'package:to_do_app/features/home/presentation/view_models/providers/to_do_provider.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/task_item.dart';

void main() {
  late ToDoModel toDoModel;
  late ToDoProvider toDoProvider;
  late Box<ToDoModel> toDoBox;
  late HomeRepo homeRepo;

  // ==========================
  // فتح Hive مرة واحدة لكل الاختبارات
  // ==========================
  setUpAll(() async {
    // مجلد مؤقت فريد لكل run لتجنب lock errors على Windows
    final testDir = Directory(path.join(
      Directory.systemTemp.path,
      'hive_test_${DateTime.now().millisecondsSinceEpoch}',
    ));
    await testDir.create(recursive: true);

    Hive.init(testDir.path);
    Hive.registerAdapter(ToDoModelAdapter());
    toDoBox = await Hive.openBox<ToDoModel>('testToDoBox');

    // تنظيف بعد كل شيء
    addTearDown(() async {
      await toDoBox.clear();
      await toDoBox.close();
      await Hive.deleteBoxFromDisk('testToDoBox');
    });
  });

  // ==========================
  // إعداد بيانات جديدة قبل كل test
  // ==========================
  setUp(() async {
    await toDoBox.clear();
    toDoModel = ToDoModel(title: 'test', createdAt: DateTime.now());
    await toDoBox.add(toDoModel);
    homeRepo = HomeRepoImpl(toDoBox: toDoBox);
    toDoProvider = ToDoProvider(homeRepo: homeRepo);
  });

  // ==========================
  // Widget Tests
  // ==========================

  testWidgets('title is displayed', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: MaterialApp(home: TaskItem(toDo: toDoModel)),
      ),
    );
    expect(find.text('test'), findsOneWidget);
  });

  testWidgets('checkbox exists', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: MaterialApp(home: TaskItem(toDo: toDoModel)),
      ),
    );
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('toggle the checkbox', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: toDoProvider,
        child: MaterialApp(home: TaskItem(toDo: toDoModel)),
      ),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(toDoProvider.toDoList.first.isCompleted, true);
  });
}
