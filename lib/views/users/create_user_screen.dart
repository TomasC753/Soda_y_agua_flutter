import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/SelectItemField/select_item_field.dart';
import 'package:soda_y_agua_flutter/widgets/error_message.dart';

import 'controllers/user_create_controller.dart';

class CreateUserScreen extends GetView<UserCreateController> {
  Function() onFinish;
  User? user;
  CreateUserScreen({Key? key, required this.onFinish, this.user})
      : super(key: key);

  @override
  final controller = Get.put(UserCreateController());

  @override
  Widget build(BuildContext context) {
    controller.onFinish = onFinish;
    if (user != null) {
      controller.editMode(user!);
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
            const Text('Usuarios'),
          ],
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                          TextFormField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                                labelText: 'Nombre',
                                filled: true,
                                errorText: controller.nameError.value.isNotEmpty
                                    ? controller.nameError.value
                                    : null,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                filled: true,
                                errorText:
                                    controller.emailError.value.isNotEmpty
                                        ? controller.emailError.value
                                        : null,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                                labelText: 'Contraseña',
                                filled: true,
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
                          controller.zones.returnContentWhen(
                            onLoading: const LinearProgressIndicator(),
                            onEmpty: const Text('No se encontraron zonas'),
                            onError: ErrorMessage(
                                error: controller.zones.errorMessage.value),
                            onSuccess: SelectItemsField.multiple<int>(
                                textController: controller.zoneController,
                                checkedItems: user?.zones
                                    ?.map((zone) => SelectableList(
                                        title: zone.name, value: zone.id))
                                    .toList(),
                                decoration: const InputDecoration(
                                    labelText: 'Zonas',
                                    filled: true,
                                    border: roundedInputStyle,
                                    enabledBorder: roundedInputStyle),
                                onChanged: (List<int> ids) =>
                                    controller.setZones(ids),
                                items: controller.zones.data
                                    .map((zone) => SelectableList(
                                        title: zone.name, value: zone.id))
                                    .toList()),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.roles.returnContentWhen(
                            onLoading: const LinearProgressIndicator(),
                            onEmpty: const Text('No se encontraron roles'),
                            onError: ErrorMessage(
                                error: controller.roles.errorMessage.value),
                            onSuccess: SelectItemsField.multiple<int>(
                                textController: controller.rolController,
                                checkedItems: user?.roles
                                    ?.map((rol) => SelectableList(
                                        title: rol.name, value: rol.id))
                                    .toList(),
                                decoration: InputDecoration(
                                    labelText: 'Roles',
                                    filled: true,
                                    errorText:
                                        controller.rolError.value.isNotEmpty
                                            ? controller.rolError.value
                                            : null,
                                    border: roundedInputStyle,
                                    enabledBorder: roundedInputStyle),
                                onChanged: (List<int> ids) =>
                                    controller.setRoles(ids),
                                items: controller.roles.data
                                    .map((rol) => SelectableList(
                                        title: rol.name, value: rol.id))
                                    .toList()),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          user == null
                              ? GradientElevatedButton(
                                  onPressed: () => controller.create(),
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(50),
                                  child: const Text('Crear usuario'))
                              : GradientElevatedButton(
                                  onPressed: () => controller.edit(),
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(50),
                                  child: const Text('Actualizar usuario'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
    );
  }
}
