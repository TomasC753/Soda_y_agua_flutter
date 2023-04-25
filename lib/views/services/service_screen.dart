import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/views/services/EditServiceScreen.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import 'controllers/service_controller.dart';
import 'service_create_screen.dart';

class ServiceScreen extends GetView<ServiceController> {
  ServiceScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
            () => ServiceCreateScreen(
                  rechargeAction: () => controller.services.getData(),
                ),
            fullscreenDialog: true,
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 250)),
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
            const Text('Zonas'),
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
                    child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: controller.services.returnContentWhen(
                                onEmpty: const Center(
                                  child: Text('No hay zonas registradas'),
                                ),
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  child: Text(
                                    controller.services.errorMessage.value,
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
                                            controller.services.search(query),
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
                                        DataColumn(
                                            label: Text('Precio por mes'))
                                      ],
                                      rows: controller.services.printedData
                                          .map((service) => DataRow(cells: [
                                                DataCell(Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      color: Colors.red,
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () =>
                                                          Get.dialog(
                                                              AlertDialog(
                                                        title: const Text(
                                                            'Eliminar Zona'),
                                                        icon: const Icon(
                                                            Icons.warning),
                                                        iconColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .error,
                                                        content: Text(
                                                            '¿Estas seguro que deseas eliminar ${service.name}?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                  'Cancelar')),
                                                          TextButton(
                                                            onPressed: () => {
                                                              Service
                                                                  .crudFunctionalities
                                                                  .destroy(
                                                                      service
                                                                          .id),
                                                              Get.back(),
                                                              controller
                                                                  .services
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
                                                        onPressed: () => controller
                                                            .service
                                                            .getData(
                                                                id: service.id,
                                                                whileLoading:
                                                                    AlertDialog(
                                                                        content:
                                                                            Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    CircularProgressIndicator()
                                                                  ],
                                                                )),
                                                                onSuccess:
                                                                    (observice) =>
                                                                        Get.to(
                                                                            EditServiceScreen(
                                                                          service:
                                                                              observice,
                                                                          onFinish: () => controller
                                                                              .services
                                                                              .getData(),
                                                                        ))))
                                                  ],
                                                )),
                                                DataCell(Text(service.name)),
                                                DataCell(Text(
                                                  '\$${service.price}',
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
    ;
  }
}
