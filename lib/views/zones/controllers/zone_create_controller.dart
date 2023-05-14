import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';

class ZoneCreateController extends GetxController {
  var nameController = TextEditingController();
  var cityController = TextEditingController();

  var errorName = ''.obs;
  var errorCity = ''.obs;

  int zoneEditing = 0;

  bool validate() {
    int errors = 0;
    if (nameController.text.isEmpty) {
      errors++;
      errorName.value = 'Este campo es requirido';
    } else {
      errorName.value = '';
    }

    if (cityController.text.isEmpty) {
      errors++;
      errorCity.value = 'Este campo es requirido';
    } else {
      errorCity.value = '';
    }

    return errors < 1;
  }

  void editMode(Zone zone) {
    nameController.text = zone.name;
    cityController.text = zone.city;
    zoneEditing = zone.id;
  }

  void edit(Function? callback) async {
    if (!validate()) {
      return;
    }
    await Zone.dataService.update(
        id: zoneEditing,
        data: {"name": nameController.text, "city": cityController.text});

    nameController.text = '';
    cityController.text = '';
    Get.back();
    callback!();
  }

  void create(Function? callback) async {
    if (!validate()) {
      return;
    }

    await Zone.dataService
        .store({"name": nameController.text, "city": cityController.text});

    nameController.text = '';
    cityController.text = '';
    Get.back();
    callback!();
  }
}
