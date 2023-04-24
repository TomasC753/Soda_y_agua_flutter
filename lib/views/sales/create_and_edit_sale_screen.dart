import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Sale.dart';
import 'package:soda_y_agua_flutter/views/sales/controllers/sale_creator_controller.dart';
import 'package:soda_y_agua_flutter/widgets/CustomTextField.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import '../../widgets/SelectItemField/select_item_field.dart';

class CreateAndEditSaleScreen extends GetView<SaleCreateController> {
  Sale? sale;
  Client? client;
  Function onFinish;
  CreateAndEditSaleScreen(
      {Key? key, required this.onFinish, this.sale, this.client})
      : super(key: key);

  @override
  final controller = Get.put(SaleCreateController());

  @override
  Widget build(BuildContext context) {
    if (sale != null) {
      controller.editMode(sale!);
    }

    if (client != null) {
      controller.clientController.text = '${client!.lastName} ${client!.name}';
      controller.selectedClient.getData(id: client!.id);
    }

    controller.onFinish = onFinish;
    controller.sale = sale;
    final boldText = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize);

    final dividerColor = Theme.of(context).dividerColor;

    ScrollController scrollController = ScrollController();
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
            const Text('Registro de ventas'),
          ],
        ),
        actions: const [ToggleThemeButton()],
      ),
      body: Obx(
        () => !controller.isLoading.value
            ? Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
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
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              'Registrar una nueva venta',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            controller.clients.returnContentWhen(
                              onLoading: Column(
                                children: const [
                                  Text('Cargando clientes...'),
                                  LinearProgressIndicator()
                                ],
                              ),
                              onEmpty: const Text(
                                  'No se encontraron clientes registrados'),
                              onError: Container(
                                padding: const EdgeInsets.all(12),
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                child: Text(
                                  controller.clients.errorMessage.value,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer),
                                ),
                              ),
                              onSuccess: SelectItemsField.single<int>(
                                  textController: controller.clientController,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      labelText: 'Cliente',
                                      border: roundedInputStyle,
                                      enabledBorder: roundedInputStyle),
                                  items: controller.clients.data
                                      .map((client) => SelectableList(
                                          value: client.id,
                                          title:
                                              '${client.lastName} ${client.name}'))
                                      .toList(),
                                  onChanged: (id) => controller.selectedClient
                                      .getData(id: id)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            controller.selectedClient.returnContentWhen(
                                onEmpty: const Center(
                                    child: Text(
                                        'Selecciona un cliente para continuar')),
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: Container(
                                  padding: const EdgeInsets.all(12),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  child: Text(
                                    controller.clients.errorMessage.value,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer),
                                  ),
                                ),
                                onSuccess: Scrollbar(
                                  controller: scrollController,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: scrollController,
                                    child: DataTable(
                                        border: TableBorder(
                                          top: BorderSide(color: dividerColor),
                                          left: BorderSide(color: dividerColor),
                                          right:
                                              BorderSide(color: dividerColor),
                                          bottom:
                                              BorderSide(color: dividerColor),
                                          verticalInside:
                                              BorderSide(color: dividerColor),
                                          horizontalInside:
                                              BorderSide(color: dividerColor),
                                        ),
                                        columns: const [
                                          DataColumn(label: Text('Estado')),
                                          DataColumn(label: Text('Producto')),
                                          DataColumn(label: Text('Precio')),
                                          DataColumn(label: Text('Cobro')),
                                          DataColumn(label: Text('Cantidad')),
                                          DataColumn(label: Text('Descuento')),
                                          DataColumn(label: Text('Total')),
                                        ],
                                        rows: controller.products.printedData
                                            .map((product) => DataRow(
                                                    color: controller
                                                                    .productSelection[
                                                                product.id] !=
                                                            null
                                                        ? MaterialStatePropertyAll(
                                                            Theme.of(context)
                                                                .cardColor)
                                                        : MaterialStatePropertyAll(
                                                            Theme.of(context)
                                                                .disabledColor),
                                                    cells: [
                                                      DataCell(Switch(
                                                          value: controller
                                                                          .productSelection[
                                                                      product
                                                                          .id] !=
                                                                  null
                                                              ? true
                                                              : false,
                                                          onChanged: (value) =>
                                                              controller
                                                                  .changeStateProduct(
                                                                      product,
                                                                      value))),
                                                      DataCell(
                                                          Text(product.name)),
                                                      DataCell(Text(
                                                        '\$${controller.selectedClient.data.value?.productPrices?.firstWhereOrNull((loopProduct) => loopProduct.productId == product.id)?.price ?? product.price}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )),
                                                      DataCell(
                                                          controller.productSelection[
                                                                      product
                                                                          .id] !=
                                                                  null
                                                              ? CustomTextField(
                                                                  controller: controller
                                                                              .productSelection[
                                                                          product
                                                                              .id]![
                                                                      'priceSold'],
                                                                  prefix:
                                                                      const Text(
                                                                          '\$'),
                                                                  onChanged: (value) =>
                                                                      controller.priceSoldAction(
                                                                          value,
                                                                          product),
                                                                )
                                                              : const Text(
                                                                  '\$0')),
                                                      DataCell(
                                                          controller.productSelection[
                                                                      product
                                                                          .id] !=
                                                                  null
                                                              ? CustomTextField(
                                                                  controller: controller
                                                                              .productSelection[
                                                                          product
                                                                              .id]![
                                                                      'quantity'],
                                                                  onChanged: (value) =>
                                                                      controller.quantityAction(
                                                                          value,
                                                                          product),
                                                                )
                                                              : const Text(
                                                                  '0')),
                                                      DataCell(
                                                          controller.productSelection[
                                                                      product
                                                                          .id] !=
                                                                  null
                                                              ? CustomTextField(
                                                                  controller: controller
                                                                              .productSelection[
                                                                          product
                                                                              .id]![
                                                                      'discount'],
                                                                  prefix:
                                                                      const Text(
                                                                          '%'),
                                                                  onChanged: (value) =>
                                                                      controller.discountAction(
                                                                          value,
                                                                          product),
                                                                )
                                                              : const Text(
                                                                  '%0')),
                                                      DataCell(Text(
                                                          '\$${controller.productSelection[product.id]?["total"] ?? 0}')),
                                                    ]))
                                            .toList()),
                                  ),
                                )),
                            // const SizedBox(
                            //   height: 16,
                            //   child: Divider(),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('Fecha:', style: boldText),
                            //     Flexible(
                            //       child: TextField(
                            //         keyboardType: TextInputType.datetime,
                            //         controller: controller.dateController,
                            //         onTap: () async =>
                            //             controller.selectDate(context),
                            //         decoration: const InputDecoration(
                            //             filled: true,
                            //             labelText: 'Ingresa la fecha',
                            //             border: roundedInputStyle,
                            //             enabledBorder: roundedInputStyle),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Entrego:', style: boldText),
                                Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller:
                                        controller.moneyDeliveredController,
                                    onChanged: (value) =>
                                        controller.setMoneyDelivered(value),
                                    decoration: const InputDecoration(
                                        prefix: Text('\$'),
                                        filled: true,
                                        labelText: 'Entrego',
                                        border: roundedInputStyle,
                                        enabledBorder: roundedInputStyle),
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Descontado:',
                                  style: boldText,
                                ),
                                Text(
                                  '%${controller.totalDiscount}',
                                  style: const TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: boldText,
                                ),
                                Text('\$${controller.total}',
                                    style: const TextStyle(color: Colors.green))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Debe:',
                                  style: boldText,
                                ),
                                Text('\$${controller.debt}',
                                    style: const TextStyle(color: Colors.red))
                              ],
                            ),
                            const Divider(),
                            sale != null
                                ? GradientElevatedButton(
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                    onPressed: () => controller.edit(),
                                    child: const Text('Actualizar venta'),
                                  )
                                : GradientElevatedButton(
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                    onPressed: () => controller.store(),
                                    child: const Text('Registrar venta'),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
