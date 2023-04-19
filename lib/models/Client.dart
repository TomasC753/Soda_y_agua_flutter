// import 'package:hive_flutter/hive_flutter.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Service.dart';
import 'Zone.dart';

class Client implements Iideable {
  @override
  int id;
  String name;
  String lastName;
  String domicile;
  String? phoneNumber;
  String? clientNumber;
  int zoneId;
  List<Service>? services;
  // List<Consumption>? consumptions;
  // List<ProductPrice>? productPrices;
  Zone? zone;
  Map? pivot;

  Client(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.domicile,
      this.phoneNumber,
      this.clientNumber,
      this.pivot,
      required this.zoneId});

  factory Client.fromJson(Map<String, dynamic> json) {
    Client client = Client(
        id: json['id'],
        name: json['name'],
        lastName: json['last_name'],
        domicile: json['domicile'],
        zoneId: json['zone_id'],
        phoneNumber: json['phone_number'],
        clientNumber: json['client_number'],
        pivot: json['pivot']);

    isFilled(
        json['services'],
        () => {
              client.services = relateMatrixToModel<Service>(
                  data: json['services'], serializerOfModel: Service.fromJson)
            });

    isFilled(
        json['zone'],
        () => client.zone = relateToModel<Zone>(
            data: json['zone'], serializerOfModel: Zone.fromJson));

    return client;
  }
}
