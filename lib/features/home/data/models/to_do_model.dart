import 'package:hive/hive.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  final DateTime createdAt;
  ToDoModel({
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });
  @override
  String toString() => 'ToDoModel(title: $title, isCompleted: $isCompleted)';
  @override
  bool operator ==(Object other) {
    if (other is ToDoModel) {
      return title == other.title &&
          isCompleted == other.isCompleted &&
          createdAt == other.createdAt;
    }
    return false;
  }
  
  @override
  int get hashCode => Object.hash(title, isCompleted, createdAt);
  
}
