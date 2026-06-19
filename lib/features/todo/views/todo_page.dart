import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final box = Hive.box('user');

    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter Your Name: ",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () => {box.put("name", nameController.text)},
                child: Text("Submit"),
              ),
              const SizedBox(height: 10),
              const Divider(),

              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, box, child) {
                  return Text(box.get('name', defaultValue: "User"));
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
