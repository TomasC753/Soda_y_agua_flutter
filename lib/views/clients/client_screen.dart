import 'package:flutter/material.dart';
import 'package:soda_y_agua_flutter/views/clients/desktop/client_screen_desktop.dart';
import 'package:soda_y_agua_flutter/widgets/Navigation/MyDrawer.dart';

import 'mobile/client_screen_mobile.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 1024
        ? ClientScreenMobile()
        : ClientScreenDesktop();
  }
}
