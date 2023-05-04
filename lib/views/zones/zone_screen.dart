import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';
import 'package:soda_y_agua_flutter/widgets/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';

import 'controllers/zone_controller.dart';
import 'controllers/zone_create_controller.dart';
import 'zone_create_and_edit_screen.dart';

class ZoneScreen extends GetView<ZoneController> {
  ZoneScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ZoneController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
                () => ZoneCreateAndEditScreen(
                      rechargeAction: controller.zones.getData,
                    ),
                fullscreenDialog: true,
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 250))
            ?.then((value) => Get.delete<ZoneCreateController>()),
        child: const Icon(Icons.add),
      ),
      title: 'Zonas',
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
                            child: controller.zones.returnContentWhen(
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
                                    controller.zones.errorMessage.value,
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
                                            controller.zones.search(query),
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
                                        DataColumn(label: Text('Ciudad'))
                                      ],
                                      rows: controller.zones.printedData
                                          .map((zone) => DataRow(cells: [
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
                                                        title: Text(
                                                            'Eliminar Zona'),
                                                        icon: const Icon(
                                                            Icons.warning),
                                                        iconColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .error,
                                                        content: Text(
                                                            '¿Estas seguro que deseas eliminar a ${zone.name} de ${zone.city}?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                  'Cancelar')),
                                                          TextButton(
                                                            onPressed: () => {
                                                              Zone.crudFunctionalities
                                                                  .destroy(
                                                                      zone.id),
                                                              Get.back(),
                                                              controller.zones
                                                                  .getData()
                                                            },
                                                            child: const Text(
                                                                'Eliminar'),
                                                            style: TextButton
                                                                .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .red),
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
                                                                    ZoneCreateAndEditScreen(
                                                                      rechargeAction: controller
                                                                          .zones
                                                                          .getData,
                                                                      zone:
                                                                          zone,
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
                                                                    ZoneCreateController>()))
                                                  ],
                                                )),
                                                DataCell(Text(zone.name)),
                                                DataCell(Text(zone.city))
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
