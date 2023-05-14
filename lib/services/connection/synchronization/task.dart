import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 12)
class Task {
  @HiveField(0)
  late int id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String? description;
  @HiveField(3)
  Function() operation;

  Task({required this.date, required this.operation, this.description}) {
    id = int.parse(DateTime.now()
        .toString()
        .replaceAll(RegExp(r'(\-|\:|\ |\.)'), '')
        .substring(0, 19 - 12));
  }

  factory Task.fromMap(Map<dynamic, dynamic> data) {
    return Task(
        date: data['date'],
        operation: data['operation'],
        description: data['description']);
  }
}
