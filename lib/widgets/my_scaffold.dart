import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';
import 'package:soda_y_agua_flutter/widgets/ToggleThemeButton.dart';

import 'MyDrawer.dart';

class MyScaffold extends StatelessWidget {
  Widget? body;
  Widget? floatingActionButton;
  String title;
  MyScaffold(
      {Key? key, this.body, this.floatingActionButton, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      drawer: MediaQuery.of(context).size.width < 1024
          ? Drawer(child: MyDrawer())
          : null,
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Row(
          children: [
            Center(
                child: Logo(
              type: LogoType.shield,
              width: 45,
            )),
            const SizedBox(
              width: 16,
            ),
            Text(title),
          ],
        ),
        actions: [
          const ToggleThemeButton(),
          IconButton(
              onPressed: () => Get.dialog(AlertDialog(
                    title: Text('¿Seguro que desea cerrar sesión?'),
                    icon: Icon(Icons.warning),
                    iconColor: Colors.orange,
                    actions: [
                      TextButton(
                          onPressed: () => Get.back(), child: Text('Cancelar')),
                      TextButton(
                          onPressed: () => Get.find<UserService>().logout(),
                          child: Text('Cerrar Sesión'))
                    ],
                  )),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: body,
    );
  }
}
