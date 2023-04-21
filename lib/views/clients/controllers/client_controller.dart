import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/services/client_service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ClientController extends GetxController {
  // TODO: ClientController

  final clientService = ClientService();
  var isLoading = false.obs;

  ResponseList<Client> clients = ResponseList<Client>(
      data: <Client>[].obs,
      status: Rxn<OperationStatus>(OperationStatus.empty),
      getterFunction: () async => ClientService().getClients(),
      conditionsForSearch: (client, query) =>
          (client.name.toLowerCase().contains(query) ||
              client.lastName.toLowerCase().contains(query)));

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    clients.getData();
  }
}
