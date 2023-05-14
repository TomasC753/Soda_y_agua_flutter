import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Consumption.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';

import 'controllers/consumption_controller.dart';

class ConsumptionScreen extends GetView<ConsumptionController> {
  Client client;
  Service service;
  ConsumptionScreen({
    Key? key,
    required this.client,
    required this.service,
  }) : super(key: key);

  @override
  final controller = Get.put(ConsumptionController());

  @override
  Widget build(BuildContext context) {
    controller.setData(client, service);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Row(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/logo_single.svg',
                width: 45,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text('Consumos de ${client.lastName} ${client.name}'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/Logo_single.svg',
                              width: 100,
                            ),
                            Text(
                              'Soda y Agua',
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ),
                        Text(
                          service.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 26,
                          child: Divider(),
                        ),
                        ...controller.products
                            .map((product) => Text(
                                'Limite de ${product.name}: ${controller.summations[product.id] ?? 0}/${product.pivot!["count"]}'))
                            .toList(),
                        const SizedBox(
                          height: 16,
                          child: Divider(),
                        ),
                        Text(
                          'Registrar consumo',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 16,
                          child: Divider(),
                        ),
                        if (controller.errorMessage.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer),
                            ),
                          ),
                        DropdownButtonFormField(
                          items: controller.products
                              .map<DropdownMenuItem<Product>>(
                                  (product) => DropdownMenuItem(
                                        value: product,
                                        child: Text(product.name),
                                      ))
                              .toList(),
                          onChanged: (product) => controller.product = product,
                          decoration: InputDecoration(
                            labelText: 'Producto',
                            filled: true,
                            errorText: controller.productError.isEmpty
                                ? null
                                : controller.productError.value,
                            border: roundedInputStyle,
                            enabledBorder: roundedInputStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => controller.addConsumption(),
                                color: Theme.of(context).colorScheme.primary,
                                icon: const Icon(Icons.add)),
                            Flexible(
                              child: TextField(
                                controller: controller.quantityToAdd,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Cantidad',
                                  filled: true,
                                  errorText:
                                      controller.quantityToAddError.isEmpty
                                          ? null
                                          : controller.quantityToAddError.value,
                                  border: roundedInputStyle,
                                  enabledBorder: roundedInputStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        controller.consumptions.returnContentWhen(
                            onEmpty: Text(
                              '${client.lastName} ${client.name} no tiene consumos este mes',
                              textAlign: TextAlign.center,
                            ),
                            onLoading: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            onError: Container(
                              padding: const EdgeInsets.all(12),
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                              child: Text(
                                controller.consumptions.errorMessage.value,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                              ),
                            ),
                            onSuccess: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Acciones')),
                                  DataColumn(label: Text('Fecha')),
                                  DataColumn(label: Text('Producto')),
                                  DataColumn(label: Text('Cantidad'))
                                ],
                                rows: controller.consumptions.printedData
                                    .map((consumption) => DataRow(cells: [
                                          DataCell(Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Colors.red,
                                                onPressed: () =>
                                                    Get.dialog(AlertDialog(
                                                  icon:
                                                      const Icon(Icons.warning),
                                                  iconColor: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  title: const Text(
                                                      'Eliminar Producto'),
                                                  content: Text(
                                                      '¿Estas seguro de que deseas eliminar este registro del ${consumption.date}?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text(
                                                            'Cancelar')),
                                                    TextButton(
                                                      onPressed: () => {
                                                        Consumption.dataService
                                                            .delete(
                                                                consumption.id),
                                                        Get.back(),
                                                        controller
                                                            .executeGetData()
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                              foregroundColor:
                                                                  Colors.red),
                                                      child: const Text(
                                                          'Eliminar'),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                              IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  color: Colors.blue,
                                                  onPressed: () =>
                                                      Get.dialog(EditDialog(
                                                        controller: controller,
                                                        consumption:
                                                            consumption,
                                                      ))),
                                            ],
                                          )),
                                          DataCell(Text(consumption.date)),
                                          DataCell(Text(controller.products
                                              .firstWhere((product) =>
                                                  product.id ==
                                                  consumption.productId)
                                              .name)),
                                          DataCell(
                                              Text('${consumption.quantity}'))
                                        ]))
                                    .toList()))
                      ],
                    ),
                  ),
                ),
              )),
            )),
    );
  }
}

class EditDialog extends StatelessWidget {
  const EditDialog(
      {super.key, required this.controller, required this.consumption});

  final ConsumptionController controller;
  final Consumption consumption;

  @override
  Widget build(BuildContext context) {
    controller.quantityToAddControllerForEdit.text = '${consumption.quantity}';
    controller.productForEdit = controller.products
        .firstWhere((product) => product.id == consumption.productId);
    return AlertDialog(
      title: const Text('Editar consumo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.errorMessageForEdit.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Text(
                controller.errorMessageForEdit.value,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
            ),
          DropdownButtonFormField(
            value: controller.products
                .firstWhere((product) => product.id == consumption.productId),
            items: controller.products
                .map<DropdownMenuItem<Product>>((product) => DropdownMenuItem(
                      value: product,
                      child: Text(product.name),
                    ))
                .toList(),
            onChanged: (product) => controller.product = product,
            decoration: InputDecoration(
              labelText: 'Producto',
              filled: true,
              errorText: controller.productErrorForEdit.isEmpty
                  ? null
                  : controller.productErrorForEdit.value,
              border: roundedInputStyle,
              enabledBorder: roundedInputStyle,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          TextField(
            controller: controller.quantityToAddControllerForEdit,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: 'Cantidad',
              filled: true,
              errorText: controller.quantityToAddErrorForEdit.isEmpty
                  ? null
                  : controller.quantityToAddErrorForEdit.value,
              border: roundedInputStyle,
              enabledBorder: roundedInputStyle,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          GradientElevatedButton(
              onPressed: () => controller.editConsuption(consumption),
              borderRadius: BorderRadius.circular(50),
              child: const Text('Editar consumo'))
        ],
      ),
    );
  }
}
