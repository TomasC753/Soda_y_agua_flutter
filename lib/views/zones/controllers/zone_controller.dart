import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ZoneController extends GetxController {
  //
  var isLoading = false.obs;

  ResponseList<Zone> zones = ResponseList<Zone>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Zone.crudFunctionalities.getAll(),
      data: <Zone>[],
      conditionsForSearch: (zone, query) =>
          zone.name.toLowerCase().contains(query) ||
          zone.city.toLowerCase().contains(query));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    zones.getData();
  }
}
