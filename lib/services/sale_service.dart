import 'package:soda_y_agua_flutter/models/Sale.dart';

import 'crud_functionalities.dart';

class SaleService {
  static final CrudFunctionalities<Sale> crudFunctionalities =
      CrudFunctionalities<Sale>(
          modelName: 'sale',
          pluralModelName: 'sales',
          serializer: Sale.fromJson);

  Future<List<Sale>> getSales() async {
    try {
      var response = await crudFunctionalities.getAll();
      if (response is List<Sale>) {
        return response;
      }
      return <Sale>[];
    } catch (e) {
      rethrow;
    }
  }
}
