import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoRepository repository;
  TodoViewModel(this.repository);

  List<TodoModel> get todos => repository.getTodos();

  void addTodo(String name, String email, String password) {
    repository.addTodo(TodoModel(name: name, email: email, password: password));
  }

  void clearTodo() {
    repository.clearTodos();
    notifyListeners();
  }
}
