import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoRepository repository;
  TodoViewModel(this.repository);

  List<TodoModel> get todos => repository.getTodos();

  void addTodo(String title, String description, bool isCompleted) {
    repository.addTodo(
      TodoModel(
        title: title,
        description: description,
        isCompleted: isCompleted,
      ),
    );
  }

  void toggleComplete(int index, TodoModel todo) {
    repository.updateTodo(
      index,
      TodoModel(
        title: todo.title,
        description: todo.description,
        isCompleted: !todo.isCompleted,
      ),
    );

    notifyListeners();
  }

  void deleteSingle(int index) {
    repository.deleteTask(index);
    notifyListeners();
  }

  void clearTodo() {
    repository.clearTodos();
    notifyListeners();
  }
}
