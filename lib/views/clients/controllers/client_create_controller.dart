import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class ClientCreateController extends GetxController {
  var isLoading = false.obs;
  late Function() onFinish;
  Client? client;
  ResponseList<Zone> zones = ResponseList<Zone>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Zone.crudFunctionalities.getAll(),
      data: <Zone>[]);

  ResponseList<Service> services = ResponseList<Service>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Service.crudFunctionalities.getAll(),
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

  void editMode(Client obClient) {
    client = obClient;
    nameController.text = obClient.name;
    lastNameController.text = obClient.lastName;
    domicileController.text = obClient.domicile;
    clientNumberController.text = obClient.clientNumber ?? '';
    phoneNumberController.text = obClient.phoneNumber ?? '';
    zoneController.text = obClient.zone!.name;
    servicesController.text =
        obClient.services?.map((e) => e.name).toString() ?? 'Ninguno';

    selectedServices.value =
        obClient.services?.map((e) => e.id).toList() ?? <int>[];
    selectedZone = obClient.zoneId;
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
    Client.crudFunctionalities.store({
      "user_id": Get.find<UserService>().user!.id,
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

  Future<void> edit() async {
    Client.crudFunctionalities.update(id: client!.id, data: {
      "user_id": Get.find<UserService>().user!.id,
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
    super.onInit();
    zones.getData();
    services.getData();
  }
}
