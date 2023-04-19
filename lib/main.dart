import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_theme/json_theme.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';

import 'routes.dart';

void main() async {
  initServices();
  ThemeData lightTheme = ThemeDecoder.decodeThemeData(
      jsonDecode(await rootBundle.loadString('assets/light_theme.json')))!;
  ThemeData darkTheme = ThemeDecoder.decodeThemeData(
      jsonDecode(await rootBundle.loadString('assets/dark_theme.json')))!;
  runApp(MyApp(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  Get.putAsync(() async => UserService());
  print('Servicios Iniciados');
}

class MyApp extends StatelessWidget {
  ThemeData lightTheme;
  ThemeData darkTheme;
  MyApp({super.key, required this.lightTheme, required this.darkTheme});

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
