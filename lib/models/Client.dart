// import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';
import 'package:hive/hive.dart';

import 'Consumption.dart';
import 'ProductPrice.dart';
import 'Sale.dart';
import 'Service.dart';
import 'Zone.dart';

part 'Client.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Client implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  @JsonKey(name: 'last_name')
  String lastName;

  @HiveField(3)
  String domicile;

  @HiveField(4)
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @HiveField(5)
  @JsonKey(name: 'client_number')
  String? clientNumber;

  @HiveField(6)
  @JsonKey(name: 'debt_state')
  int debtState;

  @HiveField(7)
  @JsonKey(name: 'zone_id')
  int zoneId;

  @HiveField(8)
  List<Service>? services;

  @HiveField(9)
  @JsonKey(name: 'last_month_consumptions')
  List<Consumption>? consumptions;

  @HiveField(10)
  @JsonKey(name: 'discount_products')
  List<ProductPrice>? productPrices;

  @HiveField(11)
  @JsonKey(
      name: 'limits_and_consumptions',
      fromJson: limitsAndConsumptionsFromJson,
      toJson: limitsAndConsumptionsToJson)
  Map<String, Map<String, int>>? limitsAndConsumptions;
  @HiveField(12)
  List<Sale>? purchases;

  @HiveField(13)
  Zone? zone;

  @HiveField(14)
  Map? pivot;

  static var dataService = DataService<Client>(
      pluralModelName: 'clients',
      singularModelName: 'client',
      serializer: Client.fromJson);

  Client(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.domicile,
      this.phoneNumber,
      this.clientNumber,
      this.limitsAndConsumptions,
      this.debtState = 0,
      this.pivot,
      required this.zoneId});

  // factory Client.fromJson(Map<dynamic, dynamic> json) {
  //   Client client = Client(
  //       id: json['id'],
  //       name: json['name'],
  //       lastName: json['last_name'],
  //       domicile: json['domicile'],
  //       zoneId: json['zone_id'],
  //       phoneNumber: json['phone_number'],
  //       clientNumber: json['client_number'],
  //       debtState: json['debt_state'],
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['services'],
  //       () => {
  //             client.services = relateMatrixToModel<Service>(
  //                 data: json['services'], serializerOfModel: Service.fromJson)
  //           });

  //   isFilled(
  //       json['zone'],
  //       () => client.zone = relateToModel<Zone>(
  //           data: json['zone'], serializerOfModel: Zone.fromJson));

  //   isFilled(
  //       json['last_month_consumptions'] ?? json['consumptions'],
  //       () => {
  //             client.consumptions = relateMatrixToModel<Consumption>(
  //                 data: json['last_month_consumptions'],
  //                 serializerOfModel: Consumption.fromJson),
  //           });

  //   isFilled(
  //       json['discount_products'],
  //       () => {
  //             client.productPrices = relateMatrixToModel<ProductPrice>(
  //                 data: json['discount_products'],
  //                 serializerOfModel: ProductPrice.fromJson)
  //           });

  //   isFilled(
  //       json['purchases'],
  //       () => {
  //             client.purchases = relateMatrixToModel<Sale>(
  //                 data: json['purchases'], serializerOfModel: Sale.fromJson)
  //           });

  //   late Map<String, dynamic> limitsAndConsumptions;
  //   late dynamic consumptions;
  //   late dynamic limits;
  //   isFilled(
  //       json['limits_and_consumptions'],
  //       () => {
  //             limitsAndConsumptions = json['limits_and_consumptions'],
  //             consumptions = limitsAndConsumptions['consumptions'],
  //             limits = limitsAndConsumptions['limits'],
  //             client.limitsAndConsumptions = <String, Map<String, int>>{},
  //             client.limitsAndConsumptions!['consumptions'] =
  //                 consumptions is Map<String, dynamic>
  //                     ? Map<String, int>.from(consumptions
  //                         .map((key, value) => MapEntry(key, value as int)))
  //                     : <String, int>{},
  //             client.limitsAndConsumptions!['limits'] = limits
  //                     is Map<String, dynamic>
  //                 ? Map<String, int>.from(
  //                     limits.map((key, value) => MapEntry(key, value as int)))
  //                 : <String, int>{}
  //           });

  //   return client;
  // }

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);

  static Map<String, dynamic> limitsAndConsumptionsToJson(
      Map<String, Map<String, int>>? limitsAndConsumptions) {
    return {
      "consumptions": limitsAndConsumptions?['consumptions'] ?? {},
      "limits": limitsAndConsumptions?['limits'] ?? {}
    };
  }

  static Map<String, Map<String, int>>? limitsAndConsumptionsFromJson(
      Map<String, dynamic>? json) {
    if (json == null || json['limits_and_consumptions'] == null) {
      return null;
    }
    Map<String, Map<String, int>> result = <String, Map<String, int>>{};
    Map<String, dynamic> limitsAndConsumptions =
        json['limits_and_consumptions'];
    dynamic consumptions = limitsAndConsumptions['consumptions'];
    dynamic limits = limitsAndConsumptions['limits'];
    result['consumptions'] = consumptions is Map<String, dynamic>
        ? Map<String, int>.from(
            consumptions.map((key, value) => MapEntry(key, value as int)))
        : <String, int>{};
    result['limits'] = limits is Map<String, dynamic>
        ? Map<String, int>.from(
            limits.map((key, value) => MapEntry(key, value as int)))
        : <String, int>{};

    return result;
  }

  Future<void> addConsumption(
      {required int serviceId,
      required int productId,
      required int quantity,
      required String dateTime}) async {
    await Consumption.dataService.store({
      'client_id': id,
      'service_id': serviceId,
      'product_id': productId,
      'quantity': quantity,
      'date': dateTime,
    });
  }
}
