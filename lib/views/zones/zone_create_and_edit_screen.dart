import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/widgets/CustomTextField.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';

import 'controllers/zone_create_controller.dart';

class ZoneCreateAndEditScreen extends GetView<ZoneCreateController> {
  Function rechargeAction;
  Zone? zone;
  ZoneCreateAndEditScreen({Key? key, required this.rechargeAction, this.zone})
      : super(key: key);

  @override
  final controller = Get.put(ZoneCreateController());

  @override
  Widget build(BuildContext context) {
    if (zone != null) {
      controller.editMode(zone!);
    }
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
            const Text('Zonas'),
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
                    CustomTextField(
                      controller: controller.nameController,
                      labelText: 'Nombre',
                      errorText: controller.errorName.value.isNotEmpty
                          ? controller.errorName.value
                          : null,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      controller: controller.cityController,
                      labelText: 'Ciudad',
                      errorText: controller.errorCity.value.isNotEmpty
                          ? controller.errorCity.value
                          : null,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    zone != null
                        ? GradientElevatedButton(
                            borderRadius: BorderRadius.circular(20),
                            width: double.infinity,
                            onPressed: () =>
                                controller.edit(() => rechargeAction()),
                            child: const Text('Editar'))
                        : GradientElevatedButton(
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
