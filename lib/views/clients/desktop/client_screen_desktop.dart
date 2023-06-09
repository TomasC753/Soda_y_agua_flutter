import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';
import 'package:soda_y_agua_flutter/views/clients/controllers/client_controller.dart';
import 'package:soda_y_agua_flutter/views/clients/create_client_screen.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';
// import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import '../show_client_screen.dart';

class ClientScreenDesktop extends GetView<ClientController> {
  ClientScreenDesktop({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        // drawer: const Drawer(child: MyDrawer()),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(
                () => CreateClientScreen(
                    onFisnih: () => controller.clients.getData()),
                fullscreenDialog: true,
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 250)),
            child: const Icon(Icons.add)),
        title: 'Registro de Clientes',
        body: Obx(
          () => !controller.isLoading.value
              ? Row(
                  children: [
                    MyNavigationRail(),
                    Expanded(
                        child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: controller.clients.returnContentWhen(
                              onLoading: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              onEmpty: const Center(
                                child: Text('No se encontraron clientes'),
                              ),
                              onError: const Center(
                                child: Text('Ocurrio un error'),
                              ),
                              onSuccess: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextField(
                                      onChanged: (query) =>
                                          controller.clients.search(query),
                                      decoration: const InputDecoration(
                                          filled: true,
                                          labelText: 'Buscar cliente',
                                          prefixIcon: Icon(Icons.search),
                                          border: roundedInputStyle,
                                          enabledBorder: roundedInputStyle),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView(
                                      children: controller
                                          .clients.printedData.value
                                          .map((client) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Card(
                                                  child: ListTile(
                                                    onTap: () => controller
                                                        .getClient(client),
                                                    onLongPress: () =>
                                                        Get.dialog(AlertDialog(
                                                      title: const Text(
                                                          'Eliminar cliente'),
                                                      icon: const Icon(
                                                          Icons.warning),
                                                      iconColor: Colors.orange,
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
                                                            Client.dataService
                                                                .delete(
                                                                    client.id),
                                                            controller.clients
                                                                .getData(),
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
                                                    leading: CircleAvatar(
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .primaryColorLight,
                                                      child: Text(
                                                          '${client.lastName[0]}${client.name[0]}'),
                                                    ),
                                                    title: Text(
                                                        '${client.lastName} ${client.name}'),
                                                    subtitle: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'Numero de cliente: ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                      TextSpan(
                                                          text: client
                                                                  .clientNumber ??
                                                              'Ninguno',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              fontSize: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .fontSize))
                                                    ])),
                                                    trailing: client
                                                                .debtState ==
                                                            0
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Colors
                                                                .greenAccent)
                                                        : const Icon(
                                                            Icons.gpp_bad,
                                                            color: Colors.red,
                                                          ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                            child: controller.selectedClient.returnContentWhen(
                                onEmpty: Logo(
                                  type: LogoType.normalOneColor,
                                  width: 250,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: Text(controller
                                    .selectedClient.errorMessage.value),
                                onSuccess: controller
                                            .selectedClient.data.value !=
                                        null
                                    ? ShowClientScreen(
                                        client: controller
                                            .selectedClient.data.value!,
                                        editAction: () => Get.to(
                                            CreateClientScreen(
                                              client: controller
                                                  .selectedClient.data.value,
                                              onFisnih: () =>
                                                  controller.clients.getData(),
                                            ),
                                            fullscreenDialog: true,
                                            transition: Transition.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 250)),
                                        deleteACtion: () =>
                                            Get.dialog(AlertDialog(
                                          title: const Text('Eliminar cliente'),
                                          icon: const Icon(Icons.warning),
                                          iconColor: Colors.orange,
                                          content: Text(
                                              '¿Estas seguro de que deseas eliminar a ${controller.selectedClient.data.value!.lastName} ${controller.selectedClient.data.value!.name}?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Get.back(),
                                                child: const Text('Cancelar')),
                                            TextButton(
                                              onPressed: () => {
                                                Client.dataService.delete(
                                                    controller.selectedClient
                                                        .data.value!.id),
                                                controller.clients.getData(),
                                                Get.back(),
                                                controller.selectedClient.status
                                                        .value =
                                                    OperationStatus.empty
                                              },
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.red),
                                              child: const Text('Eliminar'),
                                            )
                                          ],
                                        )),
                                      )
                                    : const SizedBox()))
                      ],
                    )),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
