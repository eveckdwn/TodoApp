import 'todo_status.dart';

class Todo {
  int id;
  String title;
  final DateTime createdTime;
  DateTime? modifiedTime;
  DateTime dueDate;
  TodoStatus status;

  Todo(
      {required this.id,
      required this.title,
      required this.dueDate,
      this.status = TodoStatus.incomplete})
      : createdTime = DateTime.now();
}
