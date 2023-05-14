import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:hive/hive.dart';

part 'Role.g.dart';

@JsonEnum()
enum Permission {
  @JsonValue('view roles')
  viewRoles,
  @JsonValue('view permissions')
  viewPermissions,
  // ---------------
  @JsonValue('create users')
  createUsers,
  @JsonValue('edit users')
  editUsers,
  @JsonValue('view users')
  viewUsers,
  @JsonValue('delete users')
  deleteUsers,
  // ---------------
  @JsonValue('create zones')
  createZones,
  @JsonValue('edit zones')
  editZones,
  @JsonValue('view all zones')
  viewAllZones,
  @JsonValue('view own zones')
  viewOwnZones,
  @JsonValue('delete zones')
  deletezones,
  // ---------------
  @JsonValue('create products')
  createProducts,
  @JsonValue('delete products')
  deleteProducts,
  @JsonValue('edit products')
  editProducts,
  @JsonValue('view products')
  viewProducts,
  // ---------------
  @JsonValue('create services')
  createServices,
  @JsonValue('delete services')
  deleteServices,
  @JsonValue('edit services')
  editServices,
  @JsonValue('view services')
  viewServices,
  // ---------------
  @JsonValue('create clients')
  createClients,
  @JsonValue('edit clients')
  editClients,
  @JsonValue('view all clients')
  viewAllClients,
  @JsonValue('view own clients')
  viewOwnClients,
  @JsonValue('delete clients')
  deleteClients,
  // ---------------
  @JsonValue('view all sales')
  viewAllSales,
  @JsonValue('view own sales')
  viewOwnSales,
  @JsonValue('sell products')
  sellProducts,
  // ---------------
  @JsonValue('view all invoices')
  viewAllInvoices,
  @JsonValue('view invoices of own clients')
  viewInvoicesOfOwnClients,
  @JsonValue('see own earnings')
  seeOwnEarnings,
  @JsonValue('see all earnings')
  seeAllEarnings,
}

// Map<String, Permission> permissionsMap = {
//   'view roles': Permission.viewRoles,
//   'view permissions': Permission.viewPermissions,
//   // ---------------
//   'create users': Permission.createUsers,
//   'edit users': Permission.editUsers,
//   'delete users': Permission.deleteUsers,
//   'view users': Permission.viewUsers,
//   // ---------------
//   'create zones': Permission.createZones,
//   'edit zones': Permission.editZones,
//   'delete zones': Permission.deletezones,
//   'view all zones': Permission.viewAllZones,
//   'view own zones': Permission.viewOwnZones,
//   // ---------------
//   'create products': Permission.createProducts,
//   'delete products': Permission.deleteProducts,
//   'edit products': Permission.editProducts,
//   'view products': Permission.viewProducts,
//   // ---------------
//   'create services': Permission.createServices,
//   'delete services': Permission.deleteServices,
//   'edit services': Permission.editServices,
//   'view services': Permission.viewServices,
//   // ---------------
//   'view all sales': Permission.viewAllSales,
//   'view own sales': Permission.viewOwnSales,
//   'sell products': Permission.sellProducts,
//   // ---------------
//   'create clients': Permission.createClients,
//   'delete clients': Permission.deleteClients,
//   'edit clients': Permission.editClients,
//   'view all clients': Permission.viewAllClients,
//   'view own clients': Permission.viewOwnClients,
//   // ---------------
//   'view all invoices': Permission.viewAllInvoices,
//   'view invoices of own clients': Permission.viewInvoicesOfOwnClients,
//   'see all earnings': Permission.seeAllEarnings,
//   'see own earnings': Permission.seeOwnEarnings,
// };

@HiveType(typeId: 7)
@JsonSerializable()
class Role implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  static var dataService = DataService<Role>(
      pluralModelName: 'roles',
      singularModelName: 'rol',
      serializer: Role.fromJson);

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<dynamic, dynamic> json) {
    var role = Role(id: json['id'], name: json['name']);
    return role;
  }
}

class PermissionAdapter extends TypeAdapter<Permission> {
  @override
  final int typeId = 6;

  @override
  Permission read(BinaryReader reader) {
    return Permission.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Permission obj) {
    writer.writeByte(obj.index);
  }
}
