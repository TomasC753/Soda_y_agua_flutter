import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';
import 'package:soda_y_agua_flutter/views/clients/show_client_screen.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';

import '../controllers/client_controller.dart';
import '../create_client_screen.dart';

class ClientScreenMobile extends GetView<ClientController> {
  ClientScreenMobile({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
            () => CreateClientScreen(
                  onFisnih: () => controller.clients.getData(),
                ),
            fullscreenDialog: true,
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 250)),
        child: const Icon(Icons.add),
      ),
      title: 'Clientes',
      body: Obx(
        () => !controller.isLoading.value
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      child: TextField(
                        onChanged: (query) => controller.clients.search(query),
                        decoration: const InputDecoration(
                            labelText: 'Buscar Cliente',
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            border: roundedInputStyle,
                            enabledBorder: roundedInputStyle),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: controller.clients.returnContentWhen(
                          onLoading: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          onError: const Text('Ocurrio Un error'),
                          onEmpty: const Text('No hay clientes'),
                          onSuccess: Column(
                            children: controller.clients.printedData
                                .map((client) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Card(
                                        child: ListTile(
                                          onLongPress: () =>
                                              Get.dialog(AlertDialog(
                                            title:
                                                const Text('Eliminar cliente'),
                                            icon: const Icon(Icons.warning),
                                            iconColor: Colors.orange,
                                            content: Text(
                                                '¿Estas seguro de que deseas eliminar a ${client.lastName} ${client.name}?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Get.back(),
                                                  child:
                                                      const Text('Cancelar')),
                                              TextButton(
                                                onPressed: () => {
                                                  Client.crudFunctionalities
                                                      .destroy(client.id),
                                                  controller.clients.getData(),
                                                  Get.back()
                                                },
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.red),
                                                child: const Text('Eliminar'),
                                              )
                                            ],
                                          )),
                                          onTap: () => {
                                            controller.selectedClient.getData(
                                                id: client.id,
                                                whileLoading: AlertDialog(
                                                    content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator()
                                                  ],
                                                )),
                                                onSuccess: (client) => {
                                                      Get.to(ShowClientScreen(
                                                        client: client,
                                                        deleteACtion: () =>
                                                            Get.dialog(
                                                                AlertDialog(
                                                          title: const Text(
                                                              'Eliminar cliente'),
                                                          icon: const Icon(
                                                              Icons.warning),
                                                          iconColor:
                                                              Colors.orange,
                                                          content: Text(
                                                              '¿Estas seguro de que deseas eliminar a ${client.lastName} ${client.name}?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Get.back(),
                                                                child: const Text(
                                                                    'Cancelar')),
                                                            TextButton(
                                                              onPressed: () => {
                                                                Client
                                                                    .crudFunctionalities
                                                                    .destroy(
                                                                        client
                                                                            .id),
                                                                controller
                                                                    .clients
                                                                    .getData(),
                                                                Get.back(),
                                                                Get.back()
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .red),
                                                              child: const Text(
                                                                  'Eliminar'),
                                                            )
                                                          ],
                                                        )),
                                                        editAction: () => {},
                                                      ))
                                                    })
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .primaryColorLight,
                                            child: Text(
                                                '${client.lastName[0]}${client.name[0]}'),
                                          ),
                                          title: Text(
                                              '${client.lastName} ${client.name}'),
                                          subtitle: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Numero de cliente: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                            TextSpan(
                                                text: client.clientNumber ??
                                                    'Ninguno',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .fontSize))
                                          ])),
                                          trailing: client.debtState == 0
                                              ? const Icon(Icons.check_circle,
                                                  color: Colors.greenAccent)
                                              : const Icon(
                                                  Icons.gpp_bad,
                                                  color: Colors.red,
                                                ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )))
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
