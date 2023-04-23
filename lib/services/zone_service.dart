import 'package:soda_y_agua_flutter/models/Zone.dart';

import 'crud_functionalities.dart';

class ZoneService {
  static final CrudFunctionalities<Zone> crudFunctionalities =
      CrudFunctionalities<Zone>(
          modelName: 'zone',
          pluralModelName: 'zones',
          serializer: Zone.fromJson);

  Future<List<Zone>> getZones() async {
    try {
      var response = await crudFunctionalities.getAll();
      if (response is List<Zone>) {
        return response;
      }
      return <Zone>[];
    } catch (e) {
      rethrow;
    }
  }
}
