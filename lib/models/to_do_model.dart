import 'package:hive/hive.dart';
part 'to_do_model.g.dart';
@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
 final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  String description;
  @HiveField(4)
 final DateTime createdAt;
  ToDoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.description,
    required this.createdAt,
  });
}
