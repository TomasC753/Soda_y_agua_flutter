import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Client.dart';
import 'Consumption.dart';
import 'Role.dart';
import 'Sale.dart';
import 'Zone.dart';
import 'ideable.dart';

class User implements Iideable {
  @override
  int id;
  String name;
  String email;
  String? token;
  List<Client>? clients;
  List<Role>? roles;
  List<Permission>? permissions;
  List<Zone>? zones;
  List<Sale>? sales;
  List<Consumption>? consumptions;
  Map? pivot;

  static CrudFunctionalities<User> crudFunctionalities =
      CrudFunctionalities<User>(
          modelName: 'user',
          pluralModelName: 'users',
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

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(
        id: json['id'],
        token: json['token'],
        name: json['name'],
        email: json['email'],
        pivot: json['pivot']);

    isFilled(
        json['client'],
        () => user.clients = relateMatrixToModel<Client>(
            data: json['clients'], serializerOfModel: Client.fromJson));

    isFilled(
        json['zones'],
        () => user.zones = relateMatrixToModel<Zone>(
            data: json['zones'], serializerOfModel: Zone.fromJson));

    isFilled(
        json['consumptions'],
        () => user.consumptions = relateMatrixToModel<Consumption>(
            data: json['consumption'],
            serializerOfModel: Consumption.fromJson));

    isFilled(
        json['sales'],
        () => user.sales = relateMatrixToModel<Sale>(
            data: json['sales'], serializerOfModel: Sale.fromJson));

    isFilled(
        json['roles'],
        () => user.roles = relateMatrixToModel<Role>(
            data: json['roles'], serializerOfModel: Role.fromJson));

    isFilled(
        json['permissions_names'],
        () => user.permissions = List<Permission>.from(json['permissions_names']
            .map((permission) => permissionsMap[permission])
            .toList()));

    return user;
  }
}
