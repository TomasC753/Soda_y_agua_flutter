import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/client_controller.dart';

class ClientScreenMobile extends GetView<ClientController> {
  ClientScreenMobile({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
