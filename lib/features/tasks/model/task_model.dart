import 'dart:convert';

class Task {
  final String id;
  final String taskName;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime deadLine;

  Task({
    required this.id,
    required this.taskName,
    required this.description,
    this.isDone = false,
    required this.deadLine,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "taskName": taskName,
      "description": description,
      "isDone": isDone,
      "deadline": deadLine.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(String id, Map<String, dynamic> map) {
    return Task(
      id: id,
      taskName: map["taskName"],
      deadLine: DateTime.parse(map["deadline"]),
      description: map["description"],
      isDone: map["isDone"] ?? false,
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Task.fromJson(String id, String source) {
    final Map<String, dynamic> map = jsonDecode(source);
    return Task.fromMap(id, map);
  }
}
