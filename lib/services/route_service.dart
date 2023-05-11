import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Role.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/views/clients/client_screen.dart';
import 'package:soda_y_agua_flutter/views/dashboard/dashboard_screen.dart';
import 'package:soda_y_agua_flutter/views/products/products_screen.dart';
import 'package:soda_y_agua_flutter/views/sales/sales_screen.dart';
import 'package:soda_y_agua_flutter/views/services/service_screen.dart';
import 'package:soda_y_agua_flutter/views/users/user_screen.dart';
import 'package:soda_y_agua_flutter/views/zones/zone_screen.dart';

import 'user_service.dart';

class RouteItem {
  String name;
  String route;
  Icon icon;
  Function() screen;

  RouteItem(
      {required this.name,
      required this.route,
      required this.screen,
      required this.icon});
}

class RouteService extends GetxService {
  //
  late List<RouteItem> routes;

  void obtainRoutes() {
    var userService = Get.find<UserService>();
    User user = userService.user!;
    routes = [
      RouteItem(
          icon: const Icon(Icons.dashboard),
          name: 'Dashboard',
          route: '/dashboard',
          screen: () => const DashboardScreen()),
      // -------------------------------------------------------------------------
      if (user.permissions?.contains(Permission.viewUsers) ?? false)
        RouteItem(
            icon: const Icon(Icons.headset_mic_outlined),
            name: 'Personal',
            route: '/users',
            screen: () => UserScreen()),
      // -------------------------------------------------------------------------
      if ((user.permissions?.contains(Permission.viewAllClients) ?? false) ||
          (user.permissions?.contains(Permission.viewOwnClients) ?? false))
        RouteItem(
            icon: const Icon(Icons.group),
            name: 'Clientes',
            route: '/clients',
            screen: () => const ClientScreen()),
      // -------------------------------------------------------------------------
      if (user.permissions?.contains(Permission.viewAllZones) ?? false)
        RouteItem(
            icon: const Icon(Icons.location_on),
            name: 'Zonas',
            route: '/zones',
            screen: () => ZoneScreen()),
      // -------------------------------------------------------------------------
      if (user.roles?.any((rol) => rol.name == 'admin') ?? false)
        RouteItem(
            icon: const Icon(Icons.local_grocery_store_rounded),
            name: 'Productos',
            route: 'products',
            screen: () => ProductsScreen()),
      // -------------------------------------------------------------------------
      if (user.roles?.any((rol) => rol.name == 'admin') ?? false)
        RouteItem(
            icon: const Icon(Icons.view_list),
            name: 'Servicios',
            route: '/services',
            screen: () => ServiceScreen()),
      // -------------------------------------------------------------------------
      if ((user.permissions?.contains(Permission.viewAllSales) ?? false) ||
          (user.permissions?.contains(Permission.viewOwnSales) ?? false))
        RouteItem(
            icon: const Icon(Icons.local_offer),
            name: 'Ventas',
            route: '/sales',
            screen: () => SalesScreen())
    ];
  }
}
