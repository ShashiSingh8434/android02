import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final box = Hive.box('info');
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter Your Name: ",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email: ",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passController,
                decoration: const InputDecoration(
                  labelText: "Pass: ",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () => {
                  box.add({
                    'name': nameController.text,
                    'email': emailController.text,
                    'pass': passController.text,
                  }),
                  nameController.clear(),
                  emailController.clear(),
                  passController.clear(),
                },
                child: Text("Submit"),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: () => {box.clear()}, child: Text("Delete")),
              const Divider(),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, box, child) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final user = box.getAt(index) as Map;

                        return ListTile(
                          title: Text(user['name']),
                          subtitle: Text(user['email']),
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
