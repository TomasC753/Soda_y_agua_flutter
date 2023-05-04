import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/views/products/controllers/product_controller.dart';
import 'package:soda_y_agua_flutter/views/products/controllers/product_create_controller.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';

import 'products_create_and_edit_screen.dart';

class ProductsScreen extends GetView<ProductController> {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
                () => ProductCreateAndEditScreen(
                      rechargeAction: controller.products.getData,
                    ),
                fullscreenDialog: true,
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 250))
            ?.then((value) => Get.delete<ProductCreateController>()),
        child: const Icon(Icons.add),
      ),
      title: 'Productos',
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                if (MediaQuery.of(context).size.width > 1024)
                  MyNavigationRail(),
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: controller.products.returnContentWhen(
                                onEmpty: const Center(
                                  child: Text('No hay productos registrados'),
                                ),
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  child: Text(
                                    controller.products.errorMessage.value,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer),
                                  ),
                                ),
                                onSuccess: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(17),
                                      child: TextField(
                                        onChanged: (query) =>
                                            controller.products.search(query),
                                        decoration: const InputDecoration(
                                            labelText: 'Buscar Ventas',
                                            filled: true,
                                            prefixIcon: Icon(Icons.search),
                                            border: roundedInputStyle,
                                            enabledBorder: roundedInputStyle),
                                      ),
                                    ),
                                    DataTable(
                                      columns: const [
                                        DataColumn(label: Text('Acciones')),
                                        DataColumn(label: Text('Nombre')),
                                        DataColumn(label: Text('precio')),
                                      ],
                                      rows: controller.products.printedData
                                          .map((product) => DataRow(cells: [
                                                DataCell(Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      color: Colors.red,
                                                      onPressed: () =>
                                                          Get.dialog(
                                                              AlertDialog(
                                                        icon: const Icon(
                                                            Icons.warning),
                                                        iconColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .error,
                                                        title: const Text(
                                                            'Eliminar Producto'),
                                                        content: Text(
                                                            '¿Estas seguro de que deseas eliminar ${product.name}?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                  'Cancelar')),
                                                          TextButton(
                                                            onPressed: () => {
                                                              Product
                                                                  .crudFunctionalities
                                                                  .destroy(
                                                                      product
                                                                          .id),
                                                              Get.back(),
                                                              controller
                                                                  .products
                                                                  .getData()
                                                            },
                                                            style: TextButton
                                                                .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .red),
                                                            child: const Text(
                                                                'Eliminar'),
                                                          ),
                                                        ],
                                                      )),
                                                    ),
                                                    IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        color: Colors.blue,
                                                        onPressed: () => Get.to(
                                                                () =>
                                                                    ProductCreateAndEditScreen(
                                                                      rechargeAction: controller
                                                                          .products
                                                                          .getData,
                                                                      product:
                                                                          product,
                                                                    ),
                                                                fullscreenDialog:
                                                                    true,
                                                                transition:
                                                                    Transition
                                                                        .downToUp,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            250))
                                                            ?.then((value) =>
                                                                Get.delete<
                                                                    ProductCreateController>())),
                                                  ],
                                                )),
                                                DataCell(Text(product.name)),
                                                DataCell(Text(
                                                  '\$${product.price}',
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.greenAccent),
                                                ))
                                              ]))
                                          .toList(),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            )),
    );
  }
}
