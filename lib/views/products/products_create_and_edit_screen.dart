import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';

import 'controllers/product_create_controller.dart';

class ProductCreateAndEditScreen extends GetView<ProductCreateController> {
  Function rechargeAction;
  Product? product;
  ProductCreateAndEditScreen(
      {Key? key, required this.rechargeAction, this.product})
      : super(key: key);

  @override
  final controller = Get.put(ProductCreateController());

  @override
  Widget build(BuildContext context) {
    if (product != null) {
      controller.editMode(product!);
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
            const Text('Productos'),
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
                      height: 16.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: controller.priceController,
                      decoration: InputDecoration(
                          labelText: 'Precio',
                          errorText: controller.priceError.value.isNotEmpty
                              ? controller.priceError.value
                              : null,
                          filled: true,
                          border: roundedInputStyle,
                          enabledBorder: roundedInputStyle),
                    ),
                    //
                    const SizedBox(
                      height: 16.0,
                    ),
                    product != null
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
