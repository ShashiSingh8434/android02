import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../repositories/todo_repository.dart';
import '../viewmodels/todo_viewmodel.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final box = Hive.box('info');
  final titleController = TextEditingController();
  final descController = TextEditingController();

  late final TodoViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = TodoViewModel(TodoRepository());
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Add Tasks :",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () => {
                  vm.addTodo(titleController.text, descController.text, false),

                  titleController.clear(),
                  descController.clear(),
                },
                child: Text("Submit"),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: vm.clearTodo, child: Text("Delete")),
              const Divider(),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, box, child) {
                    final todos = vm.todos;

                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        return ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) => {vm.toggleComplete(index, todo)},
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: .center,
                            crossAxisAlignment: .start,
                            children: [
                              Text(todo.description),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () => {},
                                    child: Text("Rename"),
                                  ),
                                  TextButton(
                                    onPressed: () => vm.deleteSingle(index),
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
