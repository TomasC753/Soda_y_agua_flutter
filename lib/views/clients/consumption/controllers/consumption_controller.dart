import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Consumption.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ConsumptionController extends GetxController {
  //
  var isLoading = false.obs;
  late Service service;
  late Client client;
  late List<Product> products;
  late ResponseList<Consumption> consumptions;

  var quantityToAdd = TextEditingController();
  var quantityToAddControllerForEdit = TextEditingController();
  Product? product;
  Product? productForEdit;
  RxMap<int, int> summations = <int, int>{}.obs;

  var quantityToAddError = ''.obs;
  var productError = ''.obs;
  var errorMessage = ''.obs;

  var quantityToAddErrorForEdit = ''.obs;
  var productErrorForEdit = ''.obs;
  var errorMessageForEdit = ''.obs;

  Future<void> setData(Client obClient, Service obService) async {
    client = obClient;
    service = obService;
    products = service.products ?? <Product>[];

    consumptions = ResponseList<Consumption>(
        data: <Consumption>[],
        status: Rxn(OperationStatus.empty),
        getterFunction: ({int? id}) async =>
            await Consumption.getConsumptions(client, service));

    executeGetData();
  }

  Future<void> executeGetData() async {
    await consumptions.getData(
        onSuccess: (result) =>
            summations.value = Consumption.countConsumptions(result));
  }

  bool validate() {
    int errors = 0;
    productError.value = '';
    quantityToAddError.value = '';
    errorMessage.value = '';
    if (product == null) {
      productError.value = 'Necesitas seleccionar un producto';
      errors++;
    }
    if (quantityToAdd.text.isEmpty || int.parse(quantityToAdd.text) <= 0) {
      quantityToAddError.value = 'No es una cantidad valida';
      errors++;
    }
    if ((int.tryParse(quantityToAdd.text) ?? 0) +
            (summations[product?.id ?? 0] ?? 0) >
        (product?.pivot!["count"] ?? 0)) {
      errorMessage.value =
          'Se esta excediendo el limite de productos permitido por este servicio';
      errors++;
    }

    return errors < 1;
  }

  validateForEdit(Consumption consumption) {
    int errors = 0;
    productError.value = '';
    quantityToAddError.value = '';
    errorMessageForEdit.value = '';
    if (productForEdit == null) {
      productError.value = 'Necesitas seleccionar un producto';
      errors++;
    }
    if (quantityToAddControllerForEdit.text.isEmpty ||
        int.parse(quantityToAddControllerForEdit.text) <= 0) {
      quantityToAddErrorForEdit.value = 'No es una cantidad valida';
      errors++;
    }
    if (((int.tryParse(quantityToAddControllerForEdit.text) ?? 0) -
                consumption.quantity) +
            (summations[productForEdit!.id] ?? 0) >
        productForEdit!.pivot!["count"]) {
      errorMessageForEdit.value =
          'Se esta excediendo el limite de productos permitido por este servicio';
      errors++;
    }

    return errors < 1;
  }

  Future<void> addConsumption() async {
    if (!validate()) {
      return;
    }
    client.addConsumption(
        serviceId: service.id,
        productId: product!.id,
        quantity: int.parse(quantityToAdd.text),
        dateTime: DateTime.now().toString());

    await executeGetData();
  }

  Future<void> editConsuption(Consumption consumption) async {
    if (!validateForEdit(consumption)) {
      return;
    }
    await Consumption.dataService.update(id: consumption.id, data: {
      "service_id": service.id,
      "product_id": productForEdit!.id,
      "client_id": client.id,
      "quantity": int.parse(quantityToAddControllerForEdit.text),
    });
    quantityToAdd.text = '';
    Get.back();
    await executeGetData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('Cerrando');
  }
}
