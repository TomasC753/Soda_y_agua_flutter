import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';

import 'controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor
            ]),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Logo_small_white.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 150,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Inicio de Sesión',
                            style: GoogleFonts.roboto(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (controller.statusError.isNotEmpty)
                          Container(
                            color: Theme.of(context).colorScheme.errorContainer,
                            width: double.infinity,
                            padding: const EdgeInsets.all(12.0),
                            child: Text(controller.statusError.value),
                          ),
                        const Text('Correo Electronico:'),
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Correo Electronico',
                              errorText: controller.emailError.value.isNotEmpty
                                  ? controller.emailError.value
                                  : null,
                              border: roundedInputStyle,
                              enabledBorder: roundedInputStyle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text('Contraseña:'),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Contraseña',
                              errorText:
                                  controller.passwordError.value.isNotEmpty
                                      ? controller.passwordError.value
                                      : null,
                              border: roundedInputStyle,
                              enabledBorder: roundedInputStyle),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GradientElevatedButton(
                          borderRadius: BorderRadius.circular(20),
                          width: double.infinity,
                          onPressed: () => controller.login(),
                          child: const Text('Iniciar Sesión'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
