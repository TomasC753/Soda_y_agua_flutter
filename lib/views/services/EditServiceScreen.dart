import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';

import 'controllers/service_edit_controller.dart';

class EditServiceScreen extends GetView<ServiceEditController> {
  Service service;
  Function() onFinish;
  EditServiceScreen({Key? key, required this.service, required this.onFinish})
      : super(key: key);

  @override
  ServiceEditController controller = Get.put(ServiceEditController());

  @override
  Widget build(BuildContext context) {
    controller.setService(service);
    controller.onFinish = onFinish;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => controller.close(),
            ),
            title:
                Text(service.name, style: const TextStyle(color: Colors.white)),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(18.0),
                constraints: const BoxConstraints(maxWidth: 720.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  children: [
                    EditableText(
                        controller: controller.nameController,
                        focusNode: FocusNode(),
                        style: GoogleFonts.lato(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            fontWeight: FontWeight.bold),
                        cursorColor: Theme.of(context).colorScheme.primary,
                        backgroundCursorColor:
                            Theme.of(context).colorScheme.onSurface),
                    Row(
                      children: [
                        const Text('Por mes: \$'),
                        Flexible(
                          child: EditableText(
                              controller: controller.priceController,
                              focusNode: FocusNode(),
                              style: const TextStyle(color: Colors.green),
                              cursorColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundCursorColor:
                                  Theme.of(context).colorScheme.onSurface),
                        )
                      ],
                    ),
                    const Divider(),
                    controller.products.returnContentWhen(
                        onLoading: const CircularProgressIndicator(),
                        onEmpty: const Text('No hay productos registrados'),
                        onError: Container(
                          padding: const EdgeInsets.all(12),
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: Text(
                            controller.products.errorMessage.value,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer),
                          ),
                        ),
                        onSuccess: Column(
                          children: controller.products.data
                              .map((product) => Column(
                                    children: [
                                      SwitchListTile(
                                        title: Text(product.name),
                                        value: controller.productsSelection[
                                            '${product.id}']['state'],
                                        onChanged: (value) =>
                                            controller.changeStateOfProduct(
                                                id: product.id, value: value),
                                      ),
                                      controller.productsSelection[
                                              '${product.id}']['state']
                                          ? Column(
                                              children: [
                                                TextField(
                                                  controller: controller
                                                              .productsSelection[
                                                          '${product.id}']
                                                      ['countController'],
                                                  onChanged: (value) => controller
                                                      .updateQuantityOfProduct(
                                                          id: product.id,
                                                          value: value),
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Cantidad',
                                                          filled: true,
                                                          border:
                                                              roundedInputStyle,
                                                          enabledBorder:
                                                              roundedInputStyle),
                                                ),
                                                const SizedBox(
                                                  height: 16.0,
                                                ),
                                                TextField(
                                                  controller: controller
                                                              .productsSelection[
                                                          '${product.id}']
                                                      ['priceController'],
                                                  onChanged: (value) =>
                                                      controller
                                                          .updatePriceOfProduct(
                                                              id: product.id,
                                                              value: value),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Precio',
                                                          filled: true,
                                                          border:
                                                              roundedInputStyle,
                                                          enabledBorder:
                                                              roundedInputStyle),
                                                )
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ))
                              .toList(),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
