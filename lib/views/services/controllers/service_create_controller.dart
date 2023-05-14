import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';

class ServiceCreateController extends GetxController {
  var nameController = TextEditingController();
  var priceController = TextEditingController();

  var nameError = ''.obs;
  var priceError = ''.obs;

  bool validate() {
    int errors = 0;
    if (nameController.text.isEmpty) {
      errors++;
      nameError.value = 'Este campo es requerido';
    } else {
      nameError.value = '';
    }

    if (priceController.text.isEmpty) {
      errors++;
      priceError.value = "Este campo es requerido";
    } else {
      priceError.value = "";
    }

    try {
      double.parse(priceController.text);
    } catch (e) {
      priceError.value = "Este campo es de tipo numerico";
    }

    update();
    return errors < 1;
  }

  void create(Function? callback) async {
    if (!validate()) {
      return;
    }

    await Service.dataService.store({
      "name": nameController.text,
      "price": double.parse(priceController.text)
    });

    callback!();
    Get.back();
  }
}
