import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Role.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class UserCreateController extends GetxController {
  //
  var isLoading = false.obs;
  User? user;
  late Function onFinish;

  ResponseList<Zone> zones = ResponseList<Zone>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async => Zone.crudFunctionalities.getAll(),
      data: <Zone>[]);

  ResponseList<Role> roles = ResponseList<Role>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async => Role.crudFunctionalities.getAll(),
      data: <Role>[]);

  var nameController = TextEditingController();
  var nameError = ''.obs;
  var emailController = TextEditingController();
  var emailError = ''.obs;
  var passwordController = TextEditingController();
  var passwordError = ''.obs;
  var rolController = TextEditingController();
  var rolError = ''.obs;
  var zoneController = TextEditingController();

  List<int> listRoles = <int>[];
  List<int> listZones = <int>[];

  void setRoles(List<int> ids) {
    listRoles = ids;
  }

  void setZones(List<int> ids) {
    listZones = ids;
  }

  void editMode(User obUser) {
    nameController.text = obUser.name;
    emailController.text = obUser.email;
    passwordController.text = '';
    rolController.text =
        obUser.roles?.map((e) => e.name).toString() ?? 'Ninguno';
    listRoles = obUser.roles!.map((e) => e.id).toList();
    zoneController.text =
        obUser.zones?.map((e) => e.name).toString() ?? 'Ninguno';
    listZones = obUser.zones?.map((e) => e.id).toList() ?? <int>[];
  }

  bool validate({bool passwordRequired = true}) {
    int errors = 0;
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    rolError.value = '';
    if (nameController.text.isEmpty) {
      errors++;
      nameError.value = 'El usuario necesita un nombre';
    }
    if (emailController.text.isEmpty) {
      errors++;
      emailError.value = 'El usuario tiene que tener un email';
    }
    if (passwordRequired && passwordController.text.isEmpty) {
      errors++;
      passwordError.value = 'El usuario necesita una contraseña';
    }
    if (listRoles.isEmpty) {
      errors++;
      rolError.value = 'El usuario necesita por lo menos un rol';
    }
    return errors < 1;
  }

  Future<void> create() async {
    if (!validate()) {
      return;
    }
    await User.crudFunctionalities.store({
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'roles': listRoles,
      'zones': listZones
    });

    Get.back();
    onFinish();
  }

  Future<void> edit() async {
    if (!validate(passwordRequired: false)) {
      return;
    }
    await User.crudFunctionalities.update(id: user!.id, data: {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'roles': listRoles,
      'zones': listZones
    });

    Get.back();
    onFinish();
  }

  @override
  void onInit() {
    super.onInit();
    zones.getData();
    roles.getData();
  }
}
