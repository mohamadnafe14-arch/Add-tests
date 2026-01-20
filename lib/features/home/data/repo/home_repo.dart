import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
enum ToDoFilter { all, completed, pending }
abstract class HomeRepo {
   Box<ToDoModel> toDoBox;
   ToDoFilter filter = ToDoFilter.all;
   String searchQuery = '';
   HomeRepo(this.toDoBox);
   List<ToDoModel> getAllToDos() ;
   void addToDo(ToDoModel toDo) ;
   void removeToDo(ToDoModel toDo) ;
   void toggleToDoStatus({required ToDoModel toDo}) ;
   void updateToDo({required ToDoModel toDo, String? title}) ;
   void setSearchQuery(String query) ;
   void setFilter(ToDoFilter filter) ;
}