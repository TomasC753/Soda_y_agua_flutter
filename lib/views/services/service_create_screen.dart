import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/widgets/CustomTextField.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';

import 'controllers/service_create_controller.dart';

class ServiceCreateScreen extends GetView<ServiceCreateController> {
  Function() rechargeAction;
  ServiceCreateScreen({Key? key, required this.rechargeAction})
      : super(key: key);

  @override
  final controller = Get.put(ServiceCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Row(
          children: [
            Center(
              child: Logo(
                type: LogoType.shield,
                width: 45,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text('Servicios'),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Logo(
                      type: LogoType.compactOneColor,
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 225,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    //
                    CustomTextField(
                      labelText: 'Nombre',
                      controller: controller.nameController,
                      errorText: controller.nameError.value.isNotEmpty
                          ? controller.nameError.value
                          : null,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      labelText: 'Precio',
                      controller: controller.priceController,
                      errorText: controller.priceError.value.isNotEmpty
                          ? controller.priceError.value
                          : null,
                    ),
                    //
                    const SizedBox(
                      height: 16.0,
                    ),
                    GradientElevatedButton(
                        borderRadius: BorderRadius.circular(20),
                        width: double.infinity,
                        onPressed: () =>
                            controller.create(() => rechargeAction()),
                        child: const Text('Crear')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
