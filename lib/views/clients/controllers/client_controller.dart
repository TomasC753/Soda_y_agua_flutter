import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/services/client_service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ClientController extends GetxController {
  final clientService = ClientService();
  var isLoading = false.obs;

  ResponseList<Client> clients = ResponseList<Client>(
      data: <Client>[].obs,
      status: Rxn<OperationStatus>(OperationStatus.empty),
      getterFunction: ({int? id}) async => ClientService().getClients(),
      conditionsForSearch: (client, query) =>
          (client.name.toLowerCase().contains(query) ||
              client.lastName.toLowerCase().contains(query)));

  ResponseGeneric<Client> selectedClient = ResponseGeneric<Client>(
    data: Rxn<Client>(),
    getterFunction: ({int? id}) async =>
        await ClientService.crudFunctionalities.getById(id!),
    status: Rxn<OperationStatus>(OperationStatus.empty),
  );

  Future<void> getClient(Client client) async {
    await selectedClient.getData(id: client.id);
  }

  @override
  void onInit() async {
    super.onInit();
    clients.getData();
  }
}
