import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/services/client_service.dart';
import 'package:soda_y_agua_flutter/services/service_service.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';
import 'package:soda_y_agua_flutter/services/zone_service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ClientCreateController extends GetxController {
  var isLoading = false.obs;
  late Function() onFinish;
  ResponseList<Zone> zones = ResponseList<Zone>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async => await ZoneService().getZones(),
      data: <Zone>[]);

  ResponseList<Service> services = ResponseList<Service>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async => await ServiceService().getServices(),
      data: <Service>[]);

  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var domicileController = TextEditingController();
  var clientNumberController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var zoneController = TextEditingController();
  var servicesController = TextEditingController();
  int? selectedZone;
  var selectedServices = <int>[].obs;

  var nameError = ''.obs;
  var lastNameError = ''.obs;
  var domicileError = ''.obs;
  var zoneError = ''.obs;

  void setZone(dynamic id) {
    if (id is! int) {
      return;
    }
    selectedZone = id;
  }

  void setServices(dynamic listIds) {
    if (listIds is! List) {
      return;
    }

    selectedServices.value = List<int>.from(listIds);
  }

  bool validate() {
    int errors = 0;
    nameError.value = '';
    lastNameError.value = '';
    domicileError.value = '';
    zoneError.value = '';
    if (nameController.text.isEmpty) {
      errors++;
      nameError.value = 'Este campo es requerido';
    }
    if (lastNameController.text.isEmpty) {
      errors++;
      lastNameError.value = 'Este campo es requerido';
    }
    if (zoneController.text.isEmpty) {
      errors++;
      zoneError.value = 'Este campo es requerido';
    }
    if (domicileController.text.isEmpty) {
      errors++;
      domicileError.value = 'Este campo es requerido';
    }
    return errors < 1;
  }

  Future<void> create() async {
    if (!validate()) {
      return;
    }
    ClientService.crudFunctionalities.store({
      "user_id": Get.find<UserService>().user.id,
      "name": nameController.text,
      "last_name": lastNameController.text,
      "domicile": domicileController.text,
      "client_number": clientNumberController.text,
      "phone_number": phoneNumberController.text,
      "zone_id": selectedZone,
      "services": jsonEncode(selectedServices.value),
    });

    onFinish();
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    zones.getData();
    services.getData();
  }
}
