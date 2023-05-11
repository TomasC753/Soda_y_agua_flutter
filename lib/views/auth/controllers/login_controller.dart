import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';

class LoginController extends GetxController {
  //
  final service = Get.find<UserService>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString statusError = ''.obs;

  bool validate() {
    int errors = 0;
    emailError.value = '';
    passwordError.value = '';
    if (emailController.text.isEmpty || !emailController.text.isEmail) {
      errors++;
      emailError.value = 'No es un correo electronico valido';
    }
    if (passwordController.text.isEmpty) {
      errors++;
      passwordError.value = 'Este campo es requerido';
    }

    return !(errors > 0);
  }

  void login() async {
    if (!validate()) {
      return;
    }

    try {
      await service.login(emailController.text, passwordController.text);
    } catch (e) {
      statusError.value = e.toString();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    try {
      if (await service.checkToken()) {
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      statusError.value = e.toString();
    }
  }
}
