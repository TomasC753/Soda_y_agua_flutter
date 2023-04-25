import 'package:flutter/material.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/widgets/GradientElevatedButton.dart';

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
                                                    onPressed: () => {},
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
                      height: 300,
                      padding: const EdgeInsets.all(16),
                      child: const Center(child: Text('En construccion')),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
