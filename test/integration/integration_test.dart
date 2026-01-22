import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/features/home/presentation/views/home_view.dart';
import 'package:to_do_app/main.dart' as app;
import 'package:to_do_app/features/home/presentation/view_models/providers/to_do_provider.dart';
import 'package:to_do_app/features/home/data/repo/home_repo_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('ToDo App Integration Test', () {
    late Box<ToDoModel> toDoBox;
    late ToDoProvider toDoProvider;
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
      toDoBox = await Hive.openBox<ToDoModel>('integrationTestBox');
      final homeRepo = HomeRepoImpl(toDoBox: toDoBox);
      toDoProvider = ToDoProvider(homeRepo: homeRepo);
    });
    tearDownAll(() async {
      await toDoBox.clear();
      await toDoBox.close();
      await Hive.deleteBoxFromDisk('integrationTestBox');
    });
    testWidgets('Add and Search Task', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          child: ChangeNotifierProvider.value(
            value: toDoProvider,
            child: MaterialApp(home: HomeView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final newTask = ToDoModel(
        title: 'Integration Test Task',
        createdAt: DateTime.now(),
      );
      toDoProvider.addToDo(newTask);
      await tester.pumpAndSettle();
      expect(find.text('Integration Test Task'), findsOneWidget);
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Integration Test Task');
      await tester.pumpAndSettle();
expect(
  find.byWidgetPredicate(
    (widget) => widget is Text && widget.data == 'Integration Test Task',
  ),
  findsOneWidget,
);
    });
  });
}
