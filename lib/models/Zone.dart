import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';
import 'package:hive/hive.dart';

import '../services/connection/data_service.dart';
import 'Client.dart';
import 'User.dart';
import 'ideable.dart';

part 'Zone.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
class Zone implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String city;

  @HiveField(3)
  List<Client>? clients;

  @HiveField(4)
  List<User>? users;

  @HiveField(5)
  Map? pivot;

  static var dataService = DataService<Zone>(
      pluralModelName: 'zones',
      singularModelName: 'zone',
      serializer: Zone.fromJson);

  Zone(
      {required this.id,
      required this.name,
      required this.city,
      this.clients,
      this.users,
      this.pivot});

  // factory Zone.fromJson(Map<dynamic, dynamic> json) {
  //   Zone zone = Zone(
  //       id: json['id'],
  //       name: json['name'],
  //       city: json['city'],
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['clients'],
  //       () => {
  //             zone.clients = relateMatrixToModel<Client>(
  //                 data: json['client'], serializerOfModel: Client.fromJson)
  //           });

  //   isFilled(
  //       json['users'],
  //       () => zone.users = relateMatrixToModel<User>(
  //           data: json['users'], serializerOfModel: User.fromJson));

  //   return zone;
  // }

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}
