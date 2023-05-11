import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/services/route_service.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';

var userService = Get.find<UserService>();

class MyNavigationRailController extends GetxController {
  var expanded = false.obs;
  var currentRoute = Get.currentRoute;
  Map<int, String> pages = <int, String>{};

  void inicializeRoutes() {
    int i = 0;
    Get.find<RouteService>().routes.forEach((route) {
      pages.addAll({i: route.route});
      i++;
    });
  }

  void redirectTo(int index) {
    Get.offAndToNamed(pages[index] ?? '/dashboard');
  }
}

// class MyNavigationRail extends GetView<MyNavigationRailController> {
//   MyNavigationRail({Key? key}) : super(key: key);

//   @override
//   final controller = Get.put(MyNavigationRailController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => NavigationRail(
//           backgroundColor: Theme.of(context).dividerColor,
//           leading: IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () =>
//                 controller.expanded.value = !controller.expanded.value,
//           ),
//           extended: controller.expanded.value,
//           onDestinationSelected: (int index) => controller.redirectTo(index),
//           destinations: [
//             const NavigationRailDestination(
//                 icon: Icon(Icons.dashboard), label: Text('Dashboard')),
//             if (userService.user?.roles?.contains('admin') ?? false)
//               const NavigationRailDestination(
//                   icon: Icon(Icons.headset_mic_outlined),
//                   label: Text('Personal')),
//             const NavigationRailDestination(
//                 icon: Icon(Icons.group), label: Text('Clientes')),
//             if (userService.user?.roles?.contains('admin') ?? false)
//               const NavigationRailDestination(
//                   icon: Icon(Icons.location_on), label: Text('Zonas')),
//             if (userService.user?.roles?.contains('admin') ?? false)
//               const NavigationRailDestination(
//                   icon: Icon(Icons.local_shipping), label: Text('Productos')),
//             if (userService.user?.roles?.contains('admin') ?? false)
//               const NavigationRailDestination(
//                   icon: Icon(Icons.view_list), label: Text('Servicios')),
//             const NavigationRailDestination(
//                 icon: Icon(Icons.local_offer), label: Text('Ventas')),
//             const NavigationRailDestination(
//                 icon: Icon(Icons.folder), label: Text('Boletas')),
//           ],
//           selectedIndex: controller.pages.keys.firstWhere(
//               (key) => controller.pages[key] == controller.currentRoute,
//               orElse: () => 0),
//         ));
//   }
// }

class MyNavigationRail extends GetView<MyNavigationRailController> {
  MyNavigationRail({Key? key}) : super(key: key);

  @override
  final controller = Get.put(MyNavigationRailController());

  @override
  Widget build(BuildContext context) {
    controller.inicializeRoutes();
    return Obx(() => NavigationRail(
        extended: controller.expanded.value,
        backgroundColor: Theme.of(context).dividerColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () =>
              controller.expanded.value = !controller.expanded.value,
        ),
        onDestinationSelected: (int index) => controller.redirectTo(index),
        destinations: Get.find<RouteService>()
            .routes
            .map((route) => NavigationRailDestination(
                icon: route.icon, label: Text(route.name)))
            .toList(),
        selectedIndex: controller.pages.keys.firstWhere(
            (key) => controller.pages[key] == controller.currentRoute,
            orElse: () => 0)));
  }
}
