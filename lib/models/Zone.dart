import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Client.dart';
import 'User.dart';
import 'ideable.dart';

class Zone implements Iideable {
  @override
  int id;
  String name;
  String city;
  List<Client>? clients;
  List<User>? users;
  Map? pivot;

  static CrudFunctionalities<Zone> crudFunctionalities =
      CrudFunctionalities<Zone>(
          modelName: 'zone',
          pluralModelName: 'zones',
          serializer: Zone.fromJson);

  Zone(
      {required this.id,
      required this.name,
      required this.city,
      this.clients,
      this.users,
      this.pivot});

  factory Zone.fromJson(Map<String, dynamic> json) {
    Zone zone = Zone(
        id: json['id'],
        name: json['name'],
        city: json['city'],
        pivot: json['pivot']);

    isFilled(
        json['clients'],
        () => {
              zone.clients = relateMatrixToModel<Client>(
                  data: json['client'], serializerOfModel: Client.fromJson)
            });

    isFilled(
        json['users'],
        () => zone.users = relateMatrixToModel<User>(
            data: json['users'], serializerOfModel: User.fromJson));

    return zone;
  }
}
