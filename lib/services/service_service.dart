import 'package:soda_y_agua_flutter/models/Service.dart';

import 'crud_functionalities.dart';

class ServiceService {
  static final CrudFunctionalities<Service> crudFunctionalities =
      CrudFunctionalities<Service>(
          modelName: 'service',
          pluralModelName: 'services',
          serializer: Service.fromJson);

  Future<List<Service>> getServices() async {
    try {
      var response = await crudFunctionalities.getAll();
      if (response is List<Service>) {
        return response;
      }
      return <Service>[];
    } catch (e) {
      rethrow;
    }
  }
}
