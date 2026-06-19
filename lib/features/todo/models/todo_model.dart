class TodoModel {
  final String name;
  final String email;
  final String password;

  TodoModel({required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'pass': password};
  }

  factory TodoModel.fromMap(Map map) {
    return TodoModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
