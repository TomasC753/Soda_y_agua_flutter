import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import '../controllers/client_controller.dart';

class ClientScreenMobile extends GetView<ClientController> {
  ClientScreenMobile({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => !controller.isLoading.value
            ? CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    title: Text('Clientes'),
                    actions: [ToggleThemeButton()],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      child: const TextField(
                        decoration: InputDecoration(
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
                            children: controller.clients.data.value!
                                .map((client) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Card(
                                        child: ListTile(
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
                                              ? Icon(
                                                  Icons.monetization_on,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Icon(
                                                    Icons.money_off,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onError,
                                                  )),
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
