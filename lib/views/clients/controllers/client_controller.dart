import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/services/client_service.dart';
import 'package:soda_y_agua_flutter/services/service_response.dart';

class ClientController extends GetxController {
  // TODO: ClientController

  final clientService = ClientService();

  // Rxn<ServiceResponse<List<Client>?>> clients =
  //     Rxn<ServiceResponse<List<Client>?>>(ServiceResponse<List<Client>?>(
  //         data: null,
  //         status: RxStatus.empty(),
  //         getterFunction: ClientService().getClients));

  ServiceResponse<List<Client>?> clients = ServiceResponse<List<Client>?>(
      data: Rx(<Client>[]),
      status: RxStatus.empty(),
      getterFunction: () async => ClientService().getClients());

  // Rxn<ServiceResponse<List<Client>>> clients =
  //     Rxn<ServiceResponse<List<Client>>>(ServiceResponse<List<Client>>(
  //         data: <Client>[], status: RxStatus.loading()));

  // Rxn<ServiceResponse<Client?>> selectedClient = Rxn<ServiceResponse<Client?>>(
  //     ServiceResponse<Client?>(data: null, status: RxStatus.empty()));

  // void getMoreInfo(Client client) async {
  //   selectedClient.value?.status = RxStatus.loading();
  //   selectedClient.value = await clientService.getClientById(client.id);
  // }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // clients.value = await clientService.getClients();
    // clients.value?.getData();
    clients.getData();
  }
}
