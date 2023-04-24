// import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Consumption.dart';
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
  Map<int, List<Consumption>>? consumptionGroupedByServiceId;
  // ignore: non_constant_identifier_names
  RxMap<int, List<Consumption>> obs_consumptionGroupedByServiceId =
      RxMap<int, List<Consumption>>({});
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
      this.debtState = 0,
      this.pivot,
      required this.zoneId});

  Map<int, List<Consumption>>? groupConsumptionByServiceId() {
    if (consumptions != null) {
      Map<int, List<Consumption>> matrix = {};
      for (var consumption in consumptions!) {
        if (matrix[consumption.serviceId] == null) {
          matrix[consumption.serviceId] = [consumption];
          continue;
        }
        matrix[consumption.serviceId]!.add(consumption);
      }
      return matrix;
    }
    return null;
  }

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

    Map<int, List<Consumption>>? groupedConsumptions;
    isFilled(
        json['last_month_consumptions'],
        () => {
              client.consumptions = relateMatrixToModel<Consumption>(
                  data: json['last_month_consumptions'],
                  serializerOfModel: Consumption.fromJson),
              groupedConsumptions = client.groupConsumptionByServiceId(),
              client.consumptionGroupedByServiceId = groupedConsumptions,
              client.obs_consumptionGroupedByServiceId.value =
                  groupedConsumptions ?? {}
            });

    return client;
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

  static serializer(Map data) {
    return ProductPrice(
      productId: data['product_id'],
      serviceId: data['service_id'],
      price: data['price'].toDouble(),
      quantity: data['count'],
    );
  }
}
