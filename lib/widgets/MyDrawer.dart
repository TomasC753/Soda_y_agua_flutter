import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soda_y_agua_flutter/paints/WaveLine.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blueAccent.shade200,
              Colors.blue.shade700
            ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SODA Y AGUA',
                  style: GoogleFonts.lato(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: 150,
                  child: CustomPaint(
                      painter: WaveLine(amplitude: 15, color: Colors.white)),
                )
              ],
            )),
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
        ListTile(
          title: const Text('Zonas'),
          onTap: () => Get.offAllNamed('/zones'),
          leading: const Icon(Icons.location_on),
        ),
        ListTile(
          title: const Text('Productos'),
          onTap: () => Get.offAllNamed('/products'),
          leading: const Icon(Icons.local_shipping),
        ),
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
