import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';

import 'task.dart';

// enum TaskType { create, edit, delete }

class SynchronizationService extends GetxService {
  final List<Task> _tasks = <Task>[];
  late Box _box;

  bool get nothingPending => _tasks.isEmpty;

  int get queueSize => _tasks.length;

  void init() async {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
    _box = await Hive.openBox('functionQueue');

    _box
        .toMap()
        .forEach((key, value) => _tasks.add(Task.fromMap({key: value})));
  }

  void syncData<T extends Iideable>(Box<T> box, {List<T>? listData, T? data}) {
    if (listData != null) {
      box.clear();
      for (var data in listData) {
        box.put(data.id, data);
      }
      return;
    }
    if (data != null) {
      box.put(data.id, data);
    }
  }

  void completeAllTask() {
    for (Task task in _tasks) {
      task.operation();
      dequeue(task);
    }
  }

  void addToQueue(Function() operation, {String? description}) {
    var task = Task(
        date: DateTime.now(), operation: operation, description: description);
    _tasks.add(task);
    _box.put(task.id, task);
  }

  void dequeue(Task task) {
    _tasks.removeWhere((element) => element == task);
    _box.delete(task.id);
  }
}
