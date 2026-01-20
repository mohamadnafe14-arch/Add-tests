import 'package:hive/hive.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl({required this.toDoBox});
  @override
  ToDoFilter filter = ToDoFilter.all;

  @override
  String searchQuery = '';

  @override
  Box<ToDoModel> toDoBox;

  @override
  void addToDo(ToDoModel toDo) async {
    await toDoBox.add(toDo);
  }

  @override
  List<ToDoModel> getAllToDos() {
    List<ToDoModel> result = [];
    switch (filter) {
      case ToDoFilter.all:
      result =  toDoBox.values.toList();
        break;
      case ToDoFilter.completed:
      result =  toDoBox.values.where((element) => element.isCompleted).toList();
        break;
      case ToDoFilter.pending:
      result =  toDoBox.values.where((element) => !element.isCompleted).toList();
        break;
    }
    if (searchQuery.isNotEmpty) {
      result = result.where((element) => element.title.contains(searchQuery)).toList();
    }
    return result;
  }

  @override
  void removeToDo(ToDoModel toDo) {
    toDo.delete();
  }

  @override
  void setFilter(ToDoFilter filter) {
    this.filter = filter;
  }

  @override
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @override
  void toggleToDoStatus({required ToDoModel toDo}) {
    toDo.isCompleted = !toDo.isCompleted;
    toDo.save();
  }

  @override
  void updateToDo({required ToDoModel toDo, String? title}) {
    toDo.title = title ?? toDo.title;
    toDo.save();
  }
}
