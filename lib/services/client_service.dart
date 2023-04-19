import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';

import 'crud_functionalities.dart';
import 'service_response.dart';

class ClientService {
  static final CrudFunctionalities<Client> crudFunctionalities =
      CrudFunctionalities<Client>(
          modelName: 'client',
          pluralModelName: 'clients',
          serializer: Client.fromJson);

  // Future<ServiceResponse<List<Client>>> getClients() async {
  Future<List<Client>?> getClients() async {
    // try {
    //   var response = await crudFunctionalities.getAll();
    //   if (response is List<Client>) {
    //     return ServiceResponse<List<Client>>(
    //       data: response,
    //       status: RxStatus.success(),
    //     );
    //   }
    //   return ServiceResponse(data: <Client>[], status: RxStatus.empty());
    // } catch (e) {
    //   return ServiceResponse(
    //       data: <Client>[],
    //       status: RxStatus.error(),
    //       errorMessage: e.toString());
    // }
    try {
      var response = await crudFunctionalities.getAll();
      if (response is List<Client>) {
        return response;
      }
      return <Client>[];
    } catch (e) {
      rethrow;
    }
  }

  // Future<ServiceResponse<Client?>> getClientById(int id) async {
  //   try {
  //     var response = await crudFunctionalities.getById(id);
  //     if (response is Client) {
  //       return ServiceResponse<Client?>(
  //         data: response,
  //         status: RxStatus.success(),
  //       );
  //     }
  //     return ServiceResponse(data: null, status: RxStatus.empty());
  //   } catch (e) {
  //     return ServiceResponse(
  //         data: null, status: RxStatus.error(), errorMessage: e.toString());
  //   }
  // }
}
