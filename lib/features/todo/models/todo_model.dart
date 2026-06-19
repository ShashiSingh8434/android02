class TodoModel {
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map map) {
    return TodoModel(
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }
}
