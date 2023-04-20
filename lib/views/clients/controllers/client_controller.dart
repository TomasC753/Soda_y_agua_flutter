import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/services/client_service.dart';
import 'package:soda_y_agua_flutter/services/service_response.dart';

class ClientController extends GetxController {
  // TODO: ClientController

  final clientService = ClientService();
  var isLoading = false.obs;

  ServiceResponse<List<Client>?> clients = ServiceResponse<List<Client>?>(
      data: Rx(<Client>[]),
      status: Rxn<OperationStatus>(OperationStatus.empty),
      getterFunction: () async => ClientService().getClients());

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    clients.getData();
  }
}
