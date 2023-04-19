import 'package:flutter/material.dart';
import 'package:soda_y_agua_flutter/widgets/MyDrawer.dart';

import 'mobile/client_screen_mobile.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 720
        ? ClientScreenMobile()
        : Scaffold(
            drawer: const Drawer(
              child: MyDrawer(),
            ),
            appBar: AppBar(
              title: Text('clientes'),
            ),
            body: Container(),
          );
  }
}
