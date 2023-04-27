// import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Consumption.dart';
import 'Sale.dart';
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
  int debtState;
  int zoneId;
  List<Service>? services;
  List<Consumption>? consumptions;
  List<ProductPrice>? productPrices;
  Map<String, Map<String, int>>? limitsAndConsumptions =
      <String, Map<String, int>>{};
  List<Sale>? purchases;
  Zone? zone;
  Map? pivot;

  static CrudFunctionalities<Client> crudFunctionalities =
      CrudFunctionalities<Client>(
          modelName: 'client',
          pluralModelName: 'clients',
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

  // Map<int, List<Consumption>>? groupConsumptionByServiceId() {
  //   if (consumptions != null) {
  //     Map<int, List<Consumption>> matrix = {};
  //     for (var consumption in consumptions!) {
  //       if (matrix[consumption.serviceId] == null) {
  //         matrix[consumption.serviceId] = [consumption];
  //         continue;
  //       }
  //       matrix[consumption.serviceId]!.add(consumption);
  //     }
  //     return matrix;
  //   }
  //   return null;
  // }

  factory Client.fromJson(Map<String, dynamic> json) {
    Client client = Client(
        id: json['id'],
        name: json['name'],
        lastName: json['last_name'],
        domicile: json['domicile'],
        zoneId: json['zone_id'],
        phoneNumber: json['phone_number'],
        clientNumber: json['client_number'],
        debtState: json['debt_state'],
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

    isFilled(
        json['last_month_consumptions'],
        () => {
              client.consumptions = relateMatrixToModel<Consumption>(
                  data: json['last_month_consumptions'],
                  serializerOfModel: Consumption.fromJson),
            });

    isFilled(
        json['discount_products'],
        () => {
              client.productPrices = relateMatrixToModel<ProductPrice>(
                  data: json['discount_products'],
                  serializerOfModel: ProductPrice.fromJson)
            });

    isFilled(
        json['purchases'],
        () => {
              client.purchases = relateMatrixToModel<Sale>(
                  data: json['purchases'], serializerOfModel: Sale.fromJson)
            });

    late Map<String, dynamic> limitsAndConsumptions;
    late Map<String, dynamic> consumptions;
    late Map<String, dynamic> limits;
    isFilled(
        json['limits_and_consumptions'],
        () => {
              limitsAndConsumptions = json['limits_and_consumptions'],
              consumptions = limitsAndConsumptions['consumptions'],
              limits = limitsAndConsumptions['limits'],
              client.limitsAndConsumptions = <String, Map<String, int>>{},
              client.limitsAndConsumptions!['consumptions'] =
                  consumptions.map((key, value) => MapEntry(key, value as int)),
              client.limitsAndConsumptions!['limits'] =
                  limits.map((key, value) => MapEntry(key, value as int))
            });

    return client;
  }

  Future<void> addConsumption(
      {required int serviceId,
      required int productId,
      required int quantity,
      required String dateTime}) async {
    await Consumption.crudFunctionalities.store({
      'client_id': id,
      'service_id': serviceId,
      'product_id': productId,
      'quantity': quantity,
      'date': dateTime,
    });
  }
}

class ProductPrice {
  int productId;
  int serviceId;
  double price;
  int quantity;

  ProductPrice(
      {required this.productId,
      required this.serviceId,
      required this.price,
      required this.quantity});

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      productId: json['product_id'],
      serviceId: json['service_id'],
      price: json['price'].toDouble(),
      quantity: json['count'],
    );
  }
}
