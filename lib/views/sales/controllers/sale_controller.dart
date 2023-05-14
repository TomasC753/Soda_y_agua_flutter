import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Sale.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class SaleController extends GetxController {
  //
  var isLoading = false.obs;

  ResponseList<Sale> sales = ResponseList<Sale>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Sale.dataService.getAll(filters: {"orderBy": "DESC"}),
      data: <Sale>[],
      conditionsForSearch: (sale, query) =>
          (sale.client!.lastName.toLowerCase().contains(query) ||
              sale.client!.name.toLowerCase().contains(query)));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sales.getData();
  }
}
