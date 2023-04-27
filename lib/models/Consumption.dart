import 'package:soda_y_agua_flutter/services/api_service.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';

import 'Client.dart';
import 'Service.dart';
import 'ideable.dart';

class Consumption implements Iideable {
  @override
  int id;
  int clientId;
  int serviceId;
  int productId;
  int userId;
  int quantity;
  String date;

  static CrudFunctionalities<Consumption> crudFunctionalities =
      CrudFunctionalities<Consumption>(
          modelName: 'consumption',
          pluralModelName: 'consumptions',
          serializer: Consumption.fromJson);

  Consumption(
      {required this.id,
      required this.clientId,
      required this.serviceId,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.date});

  factory Consumption.fromJson(Map<String, dynamic> json) {
    return Consumption(
      id: json['id'],
      clientId: json['client_id'],
      serviceId: json['service_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      date: json['date'],
    );
  }

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
      var response = await ApiService().get(
          'consumption/from/${client.id}${service != null ? "/${service.id}" : ""}',
          options: await ApiService().getTokenAuthorization());
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
