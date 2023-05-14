import 'dart:math';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';

import '../interfaces/crud_interface.dart';

class HiveService<T extends Iideable> implements CrudInterface {
  // late Box<T> box; // valor asincronico
  Box<T> box;
  String name;
  Function(Map<String, dynamic>) serializer;

  HiveService(
      {required this.name, required this.serializer, required this.box});

  static Future<HiveService<Iideable>> init<E extends Iideable>(
      {required name, required serializer}) async {
    return HiveService<E>(
        name: name, serializer: serializer, box: await _initBox<E>(name));
  }

  static Future<Box<E>> _initBox<E extends Iideable>(String name) async {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
    return Hive.openBox(name);
  }

  @override
  Future<List<T>> getAll({Map? filters}) async {
    try {
      var collection = box.toMap();
      List<T> result = <T>[];
      collection.forEach((key, value) {
        result.add(value);
      });

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> getById(int id) async {
    try {
      var result = box.get(id);
      if (result != null) {
        return result;
      }
      throw ('No se encontro el dato');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> store(Map<String, dynamic> data) async {
    try {
      data['id'] = int.parse(DateTime.now()
          .toString()
          .replaceAll(RegExp(r'(\-|\:|\ |\.)'), '')
          .substring(0, 19 - 12));
      T dataToSave = serializer(data);
      box.put(dataToSave.id, dataToSave);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      T dataToSave = serializer(data);
      box.put(id, dataToSave);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      box.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
