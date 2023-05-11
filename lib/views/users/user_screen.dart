import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyNavigationRail.dart';
import 'package:soda_y_agua_flutter/widgets/RoundedInputStyle.dart';
import 'package:soda_y_agua_flutter/widgets/error_message.dart';
import 'package:soda_y_agua_flutter/widgets/my_scaffold.dart';

import 'controllers/user_controller.dart';
import 'create_user_screen.dart';

class UserScreen extends GetView<UsersController> {
  UserScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(UsersController());

  var tableScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Usuarios',
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
                () => CreateUserScreen(
                      onFinish: () => controller.users.getData(),
                    ),
                fullscreenDialog: true,
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 250))
            ?.then((value) => Get.delete<CreateUserScreen>()),
        child: const Icon(Icons.add),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Registro de usuarios',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(17),
                                  child: TextField(
                                    onChanged: (query) =>
                                        controller.users.search(query),
                                    decoration: const InputDecoration(
                                        labelText: 'Buscar Ventas',
                                        filled: true,
                                        prefixIcon: Icon(Icons.search),
                                        border: roundedInputStyle,
                                        enabledBorder: roundedInputStyle),
                                  ),
                                ),
                                controller.users.returnContentWhen(
                                  onLoading: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  onError: ErrorMessage(
                                    error: controller.users.errorMessage.value,
                                  ),
                                  onEmpty: const Center(
                                    child: Text('No hay usuarios registrados'),
                                  ),
                                  onSuccess: LayoutBuilder(
                                    builder: (context, constraints) => Obx(
                                      () => Scrollbar(
                                          controller: tableScrollController,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller: tableScrollController,
                                            child: DataTable(
                                                columnSpacing:
                                                    constraints.maxWidth / 9,
                                                border: TableBorder.all(
                                                    color: Theme.of(context)
                                                        .dividerColor),
                                                columns: const <DataColumn>[
                                                  DataColumn(
                                                      label: Text('Acciones')),
                                                  DataColumn(label: Text('ID')),
                                                  DataColumn(
                                                      label: Text('Nombre')),
                                                  DataColumn(
                                                      label: Text('Email')),
                                                  DataColumn(
                                                      label: Text('Roles')),
                                                  DataColumn(
                                                      label: Text('Zonas')),
                                                ],
                                                rows:
                                                    controller.users.printedData
                                                        .map(
                                                            (user) => DataRow(
                                                                    cells: [
                                                                      DataCell(
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          IconButton(
                                                                            icon:
                                                                                const Icon(Icons.delete),
                                                                            color:
                                                                                Colors.red,
                                                                            onPressed: () =>
                                                                                Get.dialog(AlertDialog(
                                                                              icon: const Icon(Icons.warning),
                                                                              iconColor: Theme.of(context).colorScheme.error,
                                                                              title: const Text('Eliminar Producto'),
                                                                              content: Text('¿Estas seguro de que deseas eliminar ${user.name}?'),
                                                                              actions: [
                                                                                TextButton(onPressed: () => Get.back(), child: const Text('Cancelar')),
                                                                                TextButton(
                                                                                  onPressed: () => {
                                                                                    User.crudFunctionalities.destroy(user.id),
                                                                                    Get.back(),
                                                                                    controller.users.getData()
                                                                                  },
                                                                                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                                                                                  child: const Text('Eliminar'),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed: () => controller.user.getData(
                                                                                id: user.id,
                                                                                onSuccess: (result) => Get.to(CreateUserScreen(
                                                                                      onFinish: () => controller.users.getData(),
                                                                                      user: result,
                                                                                    ))?.then((value) => Get.delete<CreateUserScreen>())),
                                                                            icon:
                                                                                const Icon(Icons.edit),
                                                                            color:
                                                                                Colors.blue,
                                                                          )
                                                                        ],
                                                                      )),
                                                                      DataCell(Text(
                                                                          '${user.id}')),
                                                                      DataCell(
                                                                          Text(user
                                                                              .name)),
                                                                      DataCell(
                                                                          Text(user
                                                                              .email)),
                                                                      DataCell(
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children:
                                                                            user.roles?.map((rol) => Text(rol.name)).toList() ??
                                                                                [
                                                                                  const Text('No asignado')
                                                                                ],
                                                                      )),
                                                                      DataCell(
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children:
                                                                            user.zones?.map((zone) => Text('${zone.name}(${zone.city})')).toList() ??
                                                                                [
                                                                                  const Text('No asignado')
                                                                                ],
                                                                      )),
                                                                    ]))
                                                        .toList()),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ))
                          ],
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
