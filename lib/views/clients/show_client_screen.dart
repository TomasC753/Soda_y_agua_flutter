import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';

import 'consumption/consumption_screen.dart';
import 'consumption/controllers/consumption_controller.dart';

class ShowClientScreen extends StatelessWidget {
  Client client;
  Function() deleteACtion;
  Function() editAction;
  ShowClientScreen(
      {Key? key,
      required this.client,
      required this.deleteACtion,
      required this.editAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serviceScrollController = ScrollController();
    var salesTableScrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          title: Text('${client.lastName} ${client.name}'),
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(width: 10),
                      const Text('Editar'),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(width: 10),
                      const Text('Eliminar'),
                    ],
                  ),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                editAction();
              } else if (value == 1) {
                deleteACtion();
              }
            }),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: client.debtState == 0
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.greenAccent,
                      child: Row(
                        children: [
                          Icon(Icons.check_circle),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                              '${client.lastName} ${client.name} esta al dia con sus pagos'),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Row(
                        children: [
                          Icon(Icons.gpp_bad),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                              '${client.lastName} ${client.name} no esta al dia con sus pagos'),
                        ],
                      )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: ${client.name}'),
                      Text('Apellido: ${client.lastName}'),
                      Text('Domicilio: ${client.domicile}'),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Numero de cliente: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: client.clientNumber ?? 'Ninguno',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Numero de telefono: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: client.phoneNumber ?? 'Ninguno',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                      ])),
                    ]),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      'Servicios Contratados',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Scrollbar(
                      controller: serviceScrollController,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: serviceScrollController,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: client.services != null
                              ? client.services!
                                  .map((service) => Card(
                                        child: SizedBox(
                                          height: 150,
                                          width: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  service.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                const Divider(),
                                                Text(
                                                    'Precio por mes: \$${service.price}'),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                GradientElevatedButton(
                                                    onPressed: () => Get.to(
                                                            () =>
                                                                ConsumptionScreen(
                                                                  client:
                                                                      client,
                                                                  service:
                                                                      service,
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
                                                                ConsumptionScreen>()),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child:
                                                        Text('Ver Consumos')),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()
                              : [
                                  const Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 250,
                                      child: Center(
                                        child: Text('No tiene servicios'),
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Compras en el ultimo mes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    // TODO: compras del cliente en el ultimo mes
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: client.purchases != null
                          ? Scrollbar(
                              controller: salesTableScrollController,
                              child: SingleChildScrollView(
                                controller: salesTableScrollController,
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(label: Text('Estado')),
                                      DataColumn(label: Text('Debe')),
                                      DataColumn(label: Text('Fecha')),
                                      DataColumn(label: Text('Productos')),
                                      DataColumn(
                                          label: Text('Descuento Total')),
                                      DataColumn(label: Text('Total')),
                                      DataColumn(label: Text('Entregado')),
                                    ],
                                    rows: client.purchases!
                                        .map((sale) =>
                                            DataRow(cells: <DataCell>[
                                              DataCell(sale.paidState == 1
                                                  ? Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: Colors
                                                              .greenAccent,
                                                        ),
                                                        Text(
                                                          'Pagado',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .greenAccent),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.gpp_bad_rounded,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          'No esta pagado',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    )),
                                              DataCell(sale.paidState == 1
                                                  ? const Text(
                                                      'Nada',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .greenAccent),
                                                    )
                                                  : Text(
                                                      '\$${sale.total - sale.moneyDelivered}',
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    )),
                                              DataCell(Text(sale.date)),
                                              DataCell(Column(
                                                children: sale.products
                                                        ?.map((product) =>
                                                            RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '• ${product.name}: '),
                                                                  TextSpan(
                                                                      text:
                                                                          '\$${product.pivot?["price_sold"]} ',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.greenAccent)),
                                                                  TextSpan(
                                                                      text:
                                                                          'x ${product.pivot?["quantity"]}')
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
                                                  style: const TextStyle(
                                                      color: Colors.red))),
                                              DataCell(Text('\$${sale.total}',
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.greenAccent))),
                                              DataCell(Text(
                                                  '\$${sale.moneyDelivered}',
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.greenAccent))),
                                            ]))
                                        .toList()),
                              ),
                            )
                          : const Center(
                              child:
                                  Text('Este cliente no tiene compras hechas')),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
