import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Text("Here is the list of tasks:-"),
          const SizedBox(height: 10),
          Text("asdfasdf"),
          const SizedBox(height: 10),
          Text("asdfasdf"),
          const SizedBox(height: 10),
          Text("asdfasdf"),
          const SizedBox(height: 10),
          Text("asdfasdf"),
        ],
      ),
    );
  }
}
