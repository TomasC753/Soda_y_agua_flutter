import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ServiceEditController extends GetxController {
  //
  late Service service;
  late Function() onFinish;

  var isLoading = false.obs;

  ResponseList<Product> products = ResponseList<Product>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Product.crudFunctionalities.getAll(),
      data: <Product>[]);

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  String originalProductsSelection = '';
  var productsSelection = {}.obs;

  void setService(Service pservice) {
    service = pservice;
    setServiceName();
    setServicePrice();
    buildMaxtrix();
  }

  void setServiceName() {
    nameController.text = service.name;
  }

  void setServicePrice() {
    priceController.text = service.price.toString();
  }

  void buildMaxtrix() {
    var builtProductSelection = {};
    for (var product in products.data) {
      late Product? productInServiceProductsList;

      if (service.products != null) {
        try {
          productInServiceProductsList = service.products!
              .firstWhere((insideProduct) => insideProduct.id == product.id);
        } catch (e) {
          productInServiceProductsList = null;
        }
      } else {
        productInServiceProductsList = null;
      }

      if (productInServiceProductsList != null) {
        builtProductSelection['${product.id}'] = {
          'state': true,
          'countController': TextEditingController(
              text: '${productInServiceProductsList.pivot!['count'] ?? 0}'),
          'count': productInServiceProductsList.pivot!['count'] ?? 0,
          'priceController': TextEditingController(
              text: '${productInServiceProductsList.pivot!['price'] ?? 0}'),
          'price': productInServiceProductsList.pivot!['price'] ?? 0
        }.obs;
      } else {
        builtProductSelection['${product.id}'] =
            {'state': false, 'count': 0, 'price': 0}.obs;
      }
    }
    productsSelection.value = builtProductSelection;
    originalProductsSelection = builtProductSelection.toString();
    nameController.text = service.name;
    priceController.text = '${service.price}';
  }

  @override
  void onInit() {
    super.onInit();
    products.getData();
  }

  void changeStateOfProduct({required int id, required bool value}) {
    productsSelection['$id']['state'] = value;
    update();
  }

  void updateQuantityOfProduct({required int id, required String value}) {
    productsSelection['$id']['count'] = double.tryParse(value) ?? 0;
  }

  void updatePriceOfProduct({required int id, required String value}) {
    productsSelection['$id']['price'] = double.tryParse(value) ?? 0;
  }

  void saveChanges(Function closeFunction) {
    List<Map> finalProductsSelection = [];
    productsSelection.forEach((key, value) {
      final product = productsSelection[key];
      finalProductsSelection.add({
        'product_id': int.parse(key),
        'state': product['state'],
        'count': product['count'],
        'price': product['price']
      });
    });
    Service.crudFunctionalities.update(id: service.id, data: {
      "name": nameController.text,
      "price": double.tryParse(priceController.text) ?? 0,
      "products": jsonEncode(finalProductsSelection)
    });

    Get.back();
    closeFunction();
    onFinish();
  }

  void close() {
    double parsedPrice = double.tryParse(priceController.text) ?? 0;
    if (productsSelection.toString() != originalProductsSelection ||
        nameController.text != service.name ||
        parsedPrice != service.price) {
      Get.dialog(AlertDialog(
        icon: const Icon(Icons.warning),
        iconColor: Colors.orange.shade300,
        title: const Text('Guardar Cambios'),
        content: const Text('¿Quieres guardar los cambios que se produjeron?'),
        actions: [
          TextButton(
            child: const Text('Descartar cambios'),
            onPressed: () => {Get.back(), Get.close(1)},
          ),
          TextButton(
            child: const Text('Guardar'),
            onPressed: () => saveChanges(() => Get.close(1)),
          )
        ],
      ));
    } else {
      Get.close(1);
    }
  }
}
