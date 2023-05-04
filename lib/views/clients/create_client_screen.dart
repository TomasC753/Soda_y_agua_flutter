import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/SelectItemField/select_item_field.dart';

import 'controllers/client_create_controller.dart';

class CreateClientScreen extends GetView<ClientCreateController> {
  Function() onFisnih;
  Client? client;
  CreateClientScreen({Key? key, required this.onFisnih, this.client})
      : super(key: key);

  @override
  final controller = Get.put(ClientCreateController());

  @override
  Widget build(BuildContext context) {
    if (client != null) {
      controller.editMode(client!);
    }
    controller.onFinish = onFisnih;
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
            const Text('Registrar un nuevo cliente'),
          ],
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 550),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Logo(
                              type: LogoType.compactOneColor,
                              color: Theme.of(context).colorScheme.onBackground,
                              width: 225,
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              client == null
                                  ? "Registrar un nuevo cliente"
                                  : "Editar cliente",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                                errorText: controller.nameError.isNotEmpty
                                    ? controller.nameError.value
                                    : null,
                                filled: true,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Apellido',
                                errorText: controller.lastNameError.isNotEmpty
                                    ? controller.lastNameError.value
                                    : null,
                                filled: true,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.domicileController,
                              decoration: InputDecoration(
                                labelText: 'Domicilio',
                                errorText:
                                    controller.domicileError.value.isNotEmpty
                                        ? controller.domicileError.value
                                        : null,
                                filled: true,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.clientNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Numero de cliente',
                                filled: true,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: controller.phoneNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Numero de telefono',
                                filled: true,
                                border: roundedInputStyle,
                                enabledBorder: roundedInputStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            controller.zones.returnContentWhen(
                              onLoading: const LinearProgressIndicator(),
                              onEmpty: const Text('No se encontraron zonas'),
                              onError: Container(
                                  padding: EdgeInsets.all(16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  child: Text(
                                      controller.zones.errorMessage.value,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError))),
                              onSuccess: SelectItemsField.single<int>(
                                  textController: controller.zoneController,
                                  onChanged: (value) =>
                                      controller.setZone(value),
                                  decoration: InputDecoration(
                                    labelText: 'Zona',
                                    filled: true,
                                    border: roundedInputStyle,
                                    enabledBorder: roundedInputStyle,
                                    errorText:
                                        controller.zoneError.value.isNotEmpty
                                            ? controller.zoneError.value
                                            : null,
                                  ),
                                  items: controller.zones.data
                                      .map((zone) => SelectableList(
                                          title: zone.name,
                                          subtitle: zone.city,
                                          value: zone.id))
                                      .toList(),
                                  selectedItem: client != null
                                      ? SelectableList(
                                          title: client!.zone!.name,
                                          value: client!.zoneId)
                                      : null),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            controller.services.returnContentWhen(
                              onLoading: const LinearProgressIndicator(),
                              onEmpty:
                                  const Text('No se encontraron servicios'),
                              onError: Container(
                                  padding: const EdgeInsets.all(16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  child: Text(
                                      controller.services.errorMessage.value,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError))),
                              onSuccess: SelectItemsField.multiple(
                                  textController: controller.servicesController,
                                  onChanged: (value) =>
                                      controller.setServices(value),
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: 'Servicios',
                                      border: roundedInputStyle,
                                      enabledBorder: roundedInputStyle),
                                  items: controller.services.data
                                      .map((service) => SelectableList(
                                          title: service.name,
                                          subtitle:
                                              'Precio por mes: \$${service.price}',
                                          value: service.id))
                                      .toList(),
                                  checkedItems: controller.client?.services
                                      ?.map((service) => SelectableList(
                                          title: service.name,
                                          subtitle:
                                              'Precio por mes: \$${service.price}',
                                          value: service.id))
                                      .toList()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            client == null
                                ? GradientElevatedButton(
                                    onPressed: () => controller.create(),
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                    child: const Text('Registrar Cliente'))
                                : GradientElevatedButton(
                                    onPressed: () => controller.edit(),
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                    child: const Text('Actualizar Cliente'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
