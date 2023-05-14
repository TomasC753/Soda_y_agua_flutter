import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ProductController extends GetxController {
  //
  var isLoading = false.obs;

  ResponseList<Product> products = ResponseList<Product>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async => Product.dataService.getAll(),
      data: <Product>[],
      conditionsForSearch: (product, query) =>
          product.name.toLowerCase().contains(query));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    products.getData();
  }
}
