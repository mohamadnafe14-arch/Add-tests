import 'package:flutter/material.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';

class ToDoProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  List<ToDoModel> toDoList = [];
  ToDoFilter filter = ToDoFilter.all;
  void setSearchQuery(String query) {
    homeRepo.setSearchQuery(query);
    _update();
  }

  ToDoProvider({required this.homeRepo}) {
    _update();
  }
  void setFilter(ToDoFilter filter) {
    homeRepo.setFilter(filter);
    _update();
  }

  void addToDo(ToDoModel toDo) {
    homeRepo.addToDo(toDo);
    _update();
  }

  void removeToDo(ToDoModel toDo) {
    homeRepo.removeToDo(toDo);
    _update();
  }

  void toggleToDoStatus({required ToDoModel toDo}) {
    homeRepo.toggleToDoStatus(toDo: toDo);
    _update();
  }

  void _update() {
    toDoList = homeRepo.getAllToDos();
    filter = homeRepo.filter;
    notifyListeners();
  }
  void updateToDo({required ToDoModel toDo, String? title}) {
    homeRepo.updateToDo(toDo: toDo, title: title);
    _update();
  }
}
