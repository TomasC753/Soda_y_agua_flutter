import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_theme/json_theme.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Consumption.dart';
import 'package:soda_y_agua_flutter/models/Invoice.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/models/Role.dart';
import 'package:soda_y_agua_flutter/models/Sale.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/models/Zone.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/connection/synchronization/synchronization_service.dart';
import 'package:soda_y_agua_flutter/services/connection/synchronization/task.dart';
import 'package:soda_y_agua_flutter/services/route_service.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';

import 'routes.dart';

Future<void> main() async {
  await initServices();
  ThemeData lightTheme = ThemeDecoder.decodeThemeData(jsonDecode(
      await rootBundle.loadString('assets/Themes/light_theme.json')))!;
  ThemeData darkTheme = ThemeDecoder.decodeThemeData(jsonDecode(
      await rootBundle.loadString('assets/Themes/dark_theme.json')))!;
  runApp(MyApp(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(ConsumptionAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(PermissionAdapter());
  Hive.registerAdapter(SaleAdapter());
  Hive.registerAdapter(ServiceAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ZoneAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(IideableAdapter());
  await Hive.initFlutter();
  await Get.putAsync(() async => SynchronizationService());
  await Get.putAsync(() async => UserService());
  await Get.putAsync(() async => RouteService());
  print('Servicios Iniciados');
}

class MyApp extends StatelessWidget {
  ThemeData lightTheme;
  ThemeData darkTheme;
  MyApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      getPages: routes,
    );
  }
}
