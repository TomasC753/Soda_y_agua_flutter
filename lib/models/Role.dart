import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';

enum Permission {
  viewRoles,
  viewPermissions,
  // ---------------
  createUsers,
  editUsers,
  viewUsers,
  deleteUsers,
  // ---------------
  createZones,
  editZones,
  viewZones,
  viewAllZones,
  viewOwnZones,
  deletezones,
  // ---------------
  createProducts,
  deleteProducts,
  editProducts,
  viewProducts,
  // ---------------
  createServices,
  deleteServices,
  editServices,
  viewServices,
  // ---------------
  createClients,
  editClients,
  viewAllClients,
  viewOwnClients,
  deleteClients,
  // ---------------
  viewAllSales,
  viewOwnSales,
  sellProducts,
  // ---------------
  viewAllInvoices,
  viewInvoicesOfOwnClients,
  seeOwnEarnings,
  seeAllEarnings,
}

Map<String, Permission> permissionsMap = {
  'view roles': Permission.viewRoles,
  'view permissions': Permission.viewPermissions,
  // ---------------
  'create users': Permission.createUsers,
  'edit users': Permission.editUsers,
  'delete users': Permission.deleteUsers,
  'view users': Permission.viewUsers,
  // ---------------
  'create zones': Permission.createZones,
  'edit zones': Permission.editZones,
  'delete zones': Permission.deletezones,
  'view all zones': Permission.viewAllZones,
  'view own zones': Permission.viewOwnZones,
  // ---------------
  'create products': Permission.createProducts,
  'delete products': Permission.deleteProducts,
  'edit products': Permission.editProducts,
  'view products': Permission.viewProducts,
  // ---------------
  'create services': Permission.createServices,
  'delete services': Permission.deleteServices,
  'edit services': Permission.editServices,
  'view services': Permission.viewServices,
  // ---------------
  'view all sales': Permission.viewAllSales,
  'view own sales': Permission.viewOwnSales,
  'sell products': Permission.sellProducts,
  // ---------------
  'create clients': Permission.createClients,
  'delete clients': Permission.deleteClients,
  'edit clients': Permission.editClients,
  'view all clients': Permission.viewAllClients,
  'view own clients': Permission.viewOwnClients,
  // ---------------
  'view all invoices': Permission.viewAllInvoices,
  'view invoices of own clients': Permission.viewInvoicesOfOwnClients,
  'see all earnings': Permission.seeAllEarnings,
  'see own earnings': Permission.seeOwnEarnings,
};

class Role implements Iideable {
  @override
  int id;
  String name;

  static var crudFunctionalities = CrudFunctionalities<Role>(
      modelName: 'rol', pluralModelName: 'roles', serializer: Role.fromJson);

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    var role = Role(id: json['id'], name: json['name']);
    return role;
  }
}
