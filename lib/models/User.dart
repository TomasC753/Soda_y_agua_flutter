import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';
import 'package:hive/hive.dart';

import '../services/connection/data_service.dart';
import 'Client.dart';
import 'Consumption.dart';
import 'Role.dart';
import 'Sale.dart';
import 'Zone.dart';
import 'ideable.dart';

part 'User.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class User implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? token;

  @HiveField(4)
  List<Client>? clients;

  @HiveField(5)
  List<Role>? roles;

  @HiveField(6)
  @JsonKey(name: 'permissions_names')
  List<Permission>? permissions;

  @HiveField(7)
  List<Zone>? zones;

  @HiveField(8)
  List<Sale>? sales;

  @HiveField(9)
  List<Consumption>? consumptions;

  @HiveField(10)
  Map? pivot;

  static var dataService = DataService<User>(
      pluralModelName: 'users',
      singularModelName: 'user',
      serializer: User.fromJson);

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.token,
      this.clients,
      this.zones,
      this.roles,
      this.permissions,
      this.consumptions,
      this.sales,
      this.pivot});

  // factory User.fromJson(Map<dynamic, dynamic> json) {
  //   User user = User(
  //       id: json['id'],
  //       token: json['token'],
  //       name: json['name'],
  //       email: json['email'],
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['client'],
  //       () => user.clients = relateMatrixToModel<Client>(
  //           data: json['clients'], serializerOfModel: Client.fromJson));

  //   isFilled(
  //       json['zones'],
  //       () => user.zones = relateMatrixToModel<Zone>(
  //           data: json['zones'], serializerOfModel: Zone.fromJson));

  //   isFilled(
  //       json['consumptions'],
  //       () => user.consumptions = relateMatrixToModel<Consumption>(
  //           data: json['consumption'],
  //           serializerOfModel: Consumption.fromJson));

  //   isFilled(
  //       json['sales'],
  //       () => user.sales = relateMatrixToModel<Sale>(
  //           data: json['sales'], serializerOfModel: Sale.fromJson));

  //   isFilled(
  //       json['roles'],
  //       () => user.roles = relateMatrixToModel<Role>(
  //           data: json['roles'], serializerOfModel: Role.fromJson));

  //   isFilled(
  //       json['permissions_names'],
  //       () => user.permissions = List<Permission>.from(json['permissions_names']
  //           .map((permission) => permissionsMap[permission])
  //           .toList()));

  //   return user;
  // }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
