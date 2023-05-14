import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';

class ProductCreateController extends GetxController {
  var nameController = TextEditingController();
  var priceController = TextEditingController();

  var nameError = ''.obs;
  var priceError = ''.obs;

  int productEditing = 0;

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

  void editMode(Product product) {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    productEditing = product.id;
  }

  void edit(Function? callback) async {
    if (!validate()) {
      return;
    }

    Product.dataService.update(id: productEditing, data: {
      "name": nameController.text,
      "price": double.parse(priceController.text)
    });

    nameController.text = '';
    priceController.text = '';
    Get.back();
    callback!();
  }

  void create(Function? callback) async {
    if (!validate()) {
      return;
    }

    await Product.dataService.store({
      "name": nameController.text,
      "price": double.parse(priceController.text)
    });

    nameController.text = '';
    priceController.text = '';
    Get.back();
    callback!();
  }
}
