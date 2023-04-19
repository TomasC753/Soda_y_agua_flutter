import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/views/auth/LoginScreen.dart';
import 'package:soda_y_agua_flutter/views/clients/client_screen.dart';
import 'package:soda_y_agua_flutter/views/dashboard/dashboard_screen.dart';

var routes = [
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/dashboard', page: () => const DashboardScreen()),
  GetPage(name: '/clients', page: () => const ClientScreen()),
  // GetPage(name: '/products', page: () => ProductScreen()),
  // GetPage(name: '/services', page: () => ServiceScreen()),
  // GetPage(name: '/zones', page: () => ZoneScreen()),
  // GetPage(name: '/sales', page: () => SaleScreen()),
];
