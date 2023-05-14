import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:hive/hive.dart';

import 'Client.dart';
import 'Service.dart';
import 'ideable.dart';

part 'Consumption.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Consumption implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  @JsonKey(name: 'client_id')
  int clientId;

  @HiveField(2)
  @JsonKey(name: 'service_id')
  int serviceId;

  @HiveField(3)
  @JsonKey(name: 'product_id')
  int productId;

  @HiveField(4)
  @JsonKey(name: 'user_id')
  int userId;

  @HiveField(5)
  int quantity;

  @HiveField(6)
  String date;

  static var dataService = DataService<Consumption>(
      pluralModelName: 'consumptions',
      singularModelName: 'consumption',
      serializer: Consumption.fromJson);

  Consumption(
      {required this.id,
      required this.clientId,
      required this.serviceId,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.date});

  // factory Consumption.fromJson(Map<dynamic, dynamic> json) {
  //   return Consumption(
  //     id: json['id'],
  //     clientId: json['client_id'],
  //     serviceId: json['service_id'],
  //     userId: json['user_id'],
  //     productId: json['product_id'],
  //     quantity: json['quantity'],
  //     date: json['date'],
  //   );
  // }

  factory Consumption.fromJson(Map<String, dynamic> json) =>
      _$ConsumptionFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumptionToJson(this);

  static Map<int, int> countConsumptions(List<Consumption> consumptions) {
    Map<int, int> productsCount = {};
    for (var consumption in consumptions) {
      if (productsCount.containsKey(consumption.productId)) {
        // productsCount[consumption.productId]! += consumption.quantity;
        productsCount[consumption.productId] =
            productsCount[consumption.productId]! + consumption.quantity;
      } else {
        productsCount[consumption.productId] = consumption.quantity;
      }
    }
    return productsCount;
  }

  static Future<List<Consumption>> getConsumptions(
      Client client, Service? service) async {
    try {
      var response = await dataService.api.get(
          'consumption/from/${client.id}${service != null ? "/${service.id}" : ""}',
          options: await dataService.api.getTokenAuthorization());
      if (response.statusCode == 200) {
        return List<Consumption>.from(response.data
            .map((consumption) => Consumption.fromJson(consumption)));
      }
      return <Consumption>[];
    } catch (e) {
      rethrow;
    }
  }

  // static Future<List<Consumption>> getConsumptions(
  //     {Client? client, int? clientId, required Service service}) async {
  //   //
  //   try {
  //     if (client != null &&
  //         client.consumptionGroupedByServiceId?[service.id] != null) {
  //       return client.consumptionGroupedByServiceId![service.id]!;
  //     }

  //     if (clientId != null) {
  //       Client client = await Client.crudFunctionalities.getById(clientId);
  //       return getConsumptions(client: client, service: service);
  //     }

  //     return <Consumption>[];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
