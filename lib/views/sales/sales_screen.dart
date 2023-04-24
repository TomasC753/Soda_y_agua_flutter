import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/views/sales/controllers/sale_creator_controller.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import 'controllers/sale_controller.dart';
import 'create_and_edit_sale_screen.dart';

class SalesScreen extends GetView<SaleController> {
  SalesScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(SaleController());

  var tableScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
                () => CreateAndEditSaleScreen(
                      onFinish: () => controller.sales.getData(),
                    ),
                fullscreenDialog: true,
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 250))
            ?.then((value) => Get.delete<SaleCreateController>()),
        child: const Icon(Icons.add),
      ),
      drawer: MediaQuery.of(context).size.width < 1024
          ? const Drawer(child: MyDrawer())
          : null,
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
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                if (MediaQuery.of(context).size.width > 1024)
                  MyNavigationRail(),
                Expanded(
                    child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registro de ventas',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Card(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              child: controller.sales.returnContentWhen(
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onEmpty: const Center(
                                  child: Text('No se encontraron ventas'),
                                ),
                                onError: Center(
                                  child:
                                      Text(controller.sales.errorMessage.value),
                                ),
                                onSuccess: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(17),
                                      child: TextField(
                                        onChanged: (query) =>
                                            controller.sales.search(query),
                                        decoration: const InputDecoration(
                                            labelText: 'Buscar Ventas',
                                            filled: true,
                                            prefixIcon: Icon(Icons.search),
                                            border: roundedInputStyle,
                                            enabledBorder: roundedInputStyle),
                                      ),
                                    ),
                                    Scrollbar(
                                      controller: tableScrollController,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: tableScrollController,
                                        child: DataTable(
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                  label: Text('Acciones')),
                                              DataColumn(
                                                  label: Text('Cliente')),
                                              DataColumn(label: Text('Estado')),
                                              DataColumn(label: Text('Debe')),
                                              DataColumn(label: Text('Fecha')),
                                              DataColumn(
                                                  label: Text('Productos')),
                                              DataColumn(
                                                  label:
                                                      Text('Descuento Total')),
                                              DataColumn(label: Text('Total')),
                                              DataColumn(
                                                  label: Text('Entregado')),
                                            ],
                                            rows: controller.sales.printedData
                                                .map((sale) => DataRow(cells: [
                                                      DataCell(Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () =>
                                                                Get.dialog(
                                                                    AlertDialog(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .warning),
                                                              iconColor: Colors
                                                                  .orangeAccent,
                                                              title: const Text(
                                                                  'Eliminar Venta'),
                                                              content: const Text(
                                                                  '¿Estas seguro de que deseas eliminar esta venta?'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    child: const Text(
                                                                        'Cancelar')),
                                                                TextButton(
                                                                  onPressed:
                                                                      () => sale
                                                                          .delete(),
                                                                  style: TextButton.styleFrom(
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
                                                            onPressed: () => Get
                                                                    .to(
                                                                        CreateAndEditSaleScreen(
                                                                          onFinish: () => controller
                                                                              .sales
                                                                              .getData(id: sale.id),
                                                                          client:
                                                                              sale.client,
                                                                          sale:
                                                                              sale,
                                                                        ),
                                                                        fullscreenDialog:
                                                                            true,
                                                                        transition: Transition
                                                                            .downToUp,
                                                                        duration: const Duration(
                                                                            milliseconds:
                                                                                250))
                                                                ?.then((value) =>
                                                                    Get.delete<
                                                                        SaleCreateController>()),
                                                            icon: const Icon(
                                                                Icons.edit),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          )
                                                        ],
                                                      )),
                                                      DataCell(Text(
                                                          '${sale.client?.lastName} ${sale.client?.name}')),
                                                      DataCell(
                                                          sale.paidState == 1
                                                              ? Row(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Colors
                                                                          .greenAccent,
                                                                    ),
                                                                    Text(
                                                                      'Pagado',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.greenAccent),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .gpp_bad_rounded,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    Text(
                                                                      'No esta pagado',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ],
                                                                )),
                                                      DataCell(
                                                          sale.paidState == 1
                                                              ? const Text(
                                                                  'Nada',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .greenAccent),
                                                                )
                                                              : Text(
                                                                  '\$${sale.total - sale.moneyDelivered}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                )),
                                                      DataCell(Text(sale.date)),
                                                      DataCell(Column(
                                                        children: sale.products
                                                                ?.map((product) =>
                                                                    RichText(
                                                                        text: TextSpan(
                                                                            children: [
                                                                          TextSpan(
                                                                              text: '• ${product.name}: '),
                                                                          TextSpan(
                                                                              text: '\$${product.pivot?["price_sold"]} ',
                                                                              style: const TextStyle(color: Colors.greenAccent)),
                                                                          TextSpan(
                                                                              text: 'x ${product.pivot?["quantity"]}')
                                                                        ],
                                                                            style: TextStyle(
                                                                                color: Theme.of(context)
                                                                                    .colorScheme
                                                                                    .onSurface))))
                                                                .toList() ??
                                                            const [
                                                              Text(
                                                                  'No hay productos registrados')
                                                            ],
                                                      )),
                                                      DataCell(Text(
                                                          '%${sale.totalDiscount}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red))),
                                                      DataCell(Text(
                                                          '\$${sale.total}',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .greenAccent))),
                                                      DataCell(Text(
                                                          '\$${sale.moneyDelivered}',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .greenAccent))),
                                                    ]))
                                                .toList()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))
              ],
            )),
    );
  }
}
