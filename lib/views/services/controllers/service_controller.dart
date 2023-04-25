import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ServiceController extends GetxController {
  //
  var isLoading = false.obs;

  ResponseList<Service> services = ResponseList<Service>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Service.crudFunctionalities.getAll(),
      data: <Service>[],
      conditionsForSearch: (service, query) =>
          service.name.toLowerCase().contains(query));

  ResponseGeneric<Service> service = ResponseGeneric<Service>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Service.crudFunctionalities.getById(id!),
      data: Rxn<Service>());

  @override
  void onInit() {
    super.onInit();
    services.getData();
  }
}
