import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/views/clients/controllers/client_controller.dart';
// import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

class ClientScreenDesktop extends GetView<ClientController> {
  ClientScreenDesktop({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const Drawer(child: MyDrawer()),
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
              const Text('Clientes'),
            ],
          ),
          actions: const [ToggleThemeButton()],
        ),
        body: Obx(
          () => !controller.isLoading.value
              ? Row(
                  children: [
                    MyNavigationRail(),
                    Expanded(
                        child: Row(
                      children: [
                        Container(
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
                                                        ? Icon(
                                                            Icons
                                                                .monetization_on,
                                                            color: Colors
                                                                    .greenAccent[
                                                                400])
                                                        : Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .error,
                                                                borderRadius:
                                                                    const BorderRadius.all(
                                                                        Radius.circular(20))),
                                                            child: Icon(
                                                              Icons.money_off,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onError,
                                                            )),
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
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/Logo_single.svg',
                              width: 250,
                            ),
                            Text(
                              'SODA Y AGUA',
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ))
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
