import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soda_y_agua_flutter/paints/WaveLine.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';
import 'package:soda_y_agua_flutter/widgets/Logos/logo.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  var userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //   Colors.blueAccent.shade200,
          //   Colors.blue.shade700
          // ])),
          child: Logo(
            type: LogoType.compactOneColor,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        ListTile(
          title: const Text('Dashboard'),
          onTap: () => Get.offAllNamed('dashboard'),
          leading: const Icon(Icons.dashboard),
        ),
        ListTile(
          title: const Text('Clientes'),
          onTap: () => Get.offAllNamed('/clients'),
          leading: const Icon(Icons.group),
        ),
        if (userService.user?.permissions?.contains('view all zones') ?? false)
          ListTile(
            title: const Text('Zonas'),
            onTap: () => Get.offAllNamed('/zones'),
            leading: const Icon(Icons.location_on),
          ),
        if (userService.user?.permissions?.contains('view products') ?? false)
          ListTile(
            title: const Text('Productos'),
            onTap: () => Get.offAllNamed('/products'),
            leading: const Icon(Icons.local_shipping),
          ),
        if (userService.user?.permissions?.contains('view services') ?? false)
          ListTile(
            title: const Text('Servicios'),
            onTap: () => Get.offAllNamed('/services'),
            leading: const Icon(Icons.view_list),
          ),
        ListTile(
          title: const Text('Ventas'),
          onTap: () => Get.offAllNamed('/sales'),
          leading: const Icon(Icons.local_offer),
        ),
        ListTile(
          title: const Text('Boletas'),
          onTap: () => {},
          leading: const Icon(Icons.folder),
        ),
      ],
    );
  }
}
