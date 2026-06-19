import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:android02/features/todo/models/todo_model.dart';

class TodoRepository {
  final Box box = Hive.box('info');

  void addTodo(TodoModel todo) {
    box.add(todo.toMap());
  }

  void markComplete(int index, TodoModel todo) {
    box.putAt(index, todo.toMap());
  }

  void clearTodos() {
    box.clear();
  }

  List<TodoModel> getTodos() {
    return box.values
        .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  ValueListenable<Box> listenable() {
    return box.listenable();
  }
}
