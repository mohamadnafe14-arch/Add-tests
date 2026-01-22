import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';

void main() {
  test('testing equality', () {
    final toDo = ToDoModel(title: 'title', createdAt: DateTime.now());
    final matcher = ToDoModel(
      title: 'title',
      createdAt: DateTime.now(),
      isCompleted: false,
    );
    expect(toDo == matcher, true);
  });
  test('creating constructor', () {
    final toDo = ToDoModel(title: 'title', createdAt: DateTime.now());
    expect(toDo.title, 'title');
    expect(toDo.isCompleted, false);
    expect(toDo.createdAt, DateTime.now());
  });
}
