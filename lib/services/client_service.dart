import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';

import 'crud_functionalities.dart';

class ClientService extends GetxService {
  static final CrudFunctionalities<Client> crudFunctionalities =
      CrudFunctionalities<Client>(
          modelName: 'cliet',
          pluralModelName: 'clients',
          serializer: Client.fromJson);

  // Future<List<Client>?> getClients() async {
  //   var response = await crudFunctionalities.getAll();
  //   if (response is List<Client>) {
  //     return response;
  //   }
  //   return null;
  // }

  // Future<Client?> getClientById(int id) async {
  //   var response = await crudFunctionalities.getById(id);
  //   if (response is Client) {
  //     return response;
  //   }
  //   return null;
  // }
}
