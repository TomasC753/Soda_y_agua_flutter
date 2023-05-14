// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 10;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      name: fields[1] as String,
      email: fields[2] as String,
      token: fields[3] as String?,
      clients: (fields[4] as List?)?.cast<Client>(),
      zones: (fields[7] as List?)?.cast<Zone>(),
      roles: (fields[5] as List?)?.cast<Role>(),
      permissions: (fields[6] as List?)?.cast<Permission>(),
      consumptions: (fields[9] as List?)?.cast<Consumption>(),
      sales: (fields[8] as List?)?.cast<Sale>(),
      pivot: (fields[10] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.clients)
      ..writeByte(5)
      ..write(obj.roles)
      ..writeByte(6)
      ..write(obj.permissions)
      ..writeByte(7)
      ..write(obj.zones)
      ..writeByte(8)
      ..write(obj.sales)
      ..writeByte(9)
      ..write(obj.consumptions)
      ..writeByte(10)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
      clients: (json['clients'] as List<dynamic>?)
          ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => Zone.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions: (json['permissions_names'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PermissionEnumMap, e))
          .toList(),
      consumptions: (json['consumptions'] as List<dynamic>?)
          ?.map((e) => Consumption.fromJson(e as Map<String, dynamic>))
          .toList(),
      sales: (json['sales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList(),
      pivot: json['pivot'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'clients': instance.clients,
      'roles': instance.roles,
      'permissions_names':
          instance.permissions?.map((e) => _$PermissionEnumMap[e]!).toList(),
      'zones': instance.zones,
      'sales': instance.sales,
      'consumptions': instance.consumptions,
      'pivot': instance.pivot,
    };

const _$PermissionEnumMap = {
  Permission.viewRoles: 'view roles',
  Permission.viewPermissions: 'view permissions',
  Permission.createUsers: 'create users',
  Permission.editUsers: 'edit users',
  Permission.viewUsers: 'view users',
  Permission.deleteUsers: 'delete users',
  Permission.createZones: 'create zones',
  Permission.editZones: 'edit zones',
  Permission.viewAllZones: 'view all zones',
  Permission.viewOwnZones: 'view own zones',
  Permission.deletezones: 'delete zones',
  Permission.createProducts: 'create products',
  Permission.deleteProducts: 'delete products',
  Permission.editProducts: 'edit products',
  Permission.viewProducts: 'view products',
  Permission.createServices: 'create services',
  Permission.deleteServices: 'delete services',
  Permission.editServices: 'edit services',
  Permission.viewServices: 'view services',
  Permission.createClients: 'create clients',
  Permission.editClients: 'edit clients',
  Permission.viewAllClients: 'view all clients',
  Permission.viewOwnClients: 'view own clients',
  Permission.deleteClients: 'delete clients',
  Permission.viewAllSales: 'view all sales',
  Permission.viewOwnSales: 'view own sales',
  Permission.sellProducts: 'sell products',
  Permission.viewAllInvoices: 'view all invoices',
  Permission.viewInvoicesOfOwnClients: 'view invoices of own clients',
  Permission.seeOwnEarnings: 'see own earnings',
  Permission.seeAllEarnings: 'see all earnings',
};
