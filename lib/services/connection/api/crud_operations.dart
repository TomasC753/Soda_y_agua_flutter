// import 'package:hive/hive.dart';
import 'dart:convert';

import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/connection/api/api_service.dart';

class ApiCrudOperations<T extends Iideable> {
  String modelName;
  Function serializer;
  final api = ApiService();

  ApiCrudOperations({required this.modelName, required this.serializer});

  Future<List<T>> getAll({Map? filters}) async {
    try {
      var tokenForSend = await api.getTokenAuthorization();
      var response = await api.get(
          '$modelName${filters != null ? "/${jsonEncode(filters)}" : ""}',
          options: tokenForSend);

      if (response.statusCode == 200) {
        // Almacenar los datos en la caja
        var list = List<T>.from(response.data.map((item) => serializer(item)));
        // await dataBox!.addAll(list);
        return list;
      }
      throw ('Error desconocido');
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getById(int id) async {
    // if (dataBox != null && dataBox!.isNotEmpty) {
    //   return dataBox!.values.firstWhere((item) => item.id == id);
    // }
    try {
      var tokenForSend = await api.getTokenAuthorization();
      var response = await api.get('$modelName/$id', options: tokenForSend);

      if (response.statusCode == 200) {
        return serializer(response.data);
      }
      throw ('Error desconocido');
    } catch (e) {
      rethrow;
    }
  }

  update({required int id, required Map<String, dynamic> data}) async {
    // TODO: Ejecutar update en modo offline
    try {
      var tokenForSend = await api.getTokenAuthorization();
      await api.put('$modelName/$id', data: data, options: tokenForSend);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  destroy(int id) async {
    // TODO: Ejecutar destroy en modo offline
    try {
      var tokenForSend = await api.getTokenAuthorization();
      await api.delete('$modelName/$id', options: tokenForSend);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  store(Map<String, dynamic> data) async {
    // TODO: Ejecutar store en modo offline
    try {
      var tokenForSend = await api.getTokenAuthorization();
      await api.post(modelName, data: data, options: tokenForSend);
    } catch (e) {
      rethrow;
    }

    return null;
  }
}
