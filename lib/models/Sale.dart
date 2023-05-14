import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:hive/hive.dart';

import '../utils/modelMatcher.dart';
import 'Client.dart';
import 'Product.dart';
import 'ideable.dart';

part 'Sale.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class Sale implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  @JsonKey(name: 'paid_state')
  int paidState;

  @HiveField(3)
  @JsonKey(name: 'paid_date')
  String? paidDate;

  @HiveField(4)
  @JsonKey(name: 'client_id')
  int clientId;

  @HiveField(5)
  @JsonKey(name: 'user_id')
  int userId;

  @HiveField(6)
  Client? client;

  @HiveField(7)
  @JsonKey(name: 'money_delivered')
  double moneyDelivered;

  @HiveField(8)
  @JsonKey(name: 'total_discount')
  double totalDiscount;

  @HiveField(9)
  double total;

  @HiveField(10)
  @JsonKey(name: 'invoice_id')
  int? invoiceId;

  @HiveField(11)
  List<Product>? products;

  @HiveField(12)
  Map? pivot;

  static var dataService = DataService<Sale>(
      pluralModelName: 'sales',
      singularModelName: 'sale',
      serializer: Sale.fromJson);

  Sale(
      {required this.id,
      required this.date,
      required this.paidState,
      this.paidDate,
      required this.clientId,
      required this.userId,
      this.client,
      this.invoiceId,
      required this.moneyDelivered,
      required this.totalDiscount,
      required this.total,
      this.products,
      this.pivot});

  // factory Sale.fromJson(Map<dynamic, dynamic> json) {
  //   Sale sale = Sale(
  //       id: json['id'],
  //       date: json['date'],
  //       paidState: json['paid_state'],
  //       paidDate: json['paid_date'],
  //       clientId: json['client_id'],
  //       userId: json['user_id'],
  //       invoiceId: json['invoice_id'],
  //       moneyDelivered: json['money_delivered'].toDouble(),
  //       totalDiscount: json['total_discount'].toDouble(),
  //       total: json['total'].toDouble(),
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['products'],
  //       () => {
  //             sale.products = relateMatrixToModel<Product>(
  //                 data: json['products'], serializerOfModel: Product.fromJson)
  //           });

  //   isFilled(
  //       json['client'],
  //       () => {
  //             sale.client = relateToModel(
  //                 data: json['client'], serializerOfModel: Client.fromJson)
  //           });

  //   return sale;
  // }

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);

  static List<Map<String, dynamic>> _buildArray(Map products) {
    List<Map<String, dynamic>> adaptedArray = [];
    products.forEach((key, product) {
      adaptedArray.add({
        "product_id": key,
        "original_price": product['originalPrice'],
        "price_sold": double.tryParse(product['priceSold'].text ?? 0),
        "service_id": product['serviceId'],
        "quantity": double.tryParse(product['quantity'].text) ?? 0,
        "discount": double.tryParse(product['discount'].text) ?? 0
      });
    });

    return adaptedArray;
  }

  static create(
      {required DateTime date,
      required int clientId,
      required int userId,
      required double total,
      double moneyDelivered = 0,
      required double totalDiscount,
      required Map products}) async {
    var adaptedArray = _buildArray(products);
    dataService.store({
      "date": date.toString(),
      "client_id": clientId,
      "user_id": userId,
      "money_delivered": moneyDelivered,
      "total": total,
      "total_discount": totalDiscount,
      "products": jsonEncode(adaptedArray)
    });
  }

  void delete() {
    dataService.delete(id);
  }

  void edit(
      {required DateTime date,
      required int clientId,
      required int userId,
      required double total,
      double moneyDelivered = 0,
      required double totalDiscount,
      required Map products}) {
    var adaptedArray = _buildArray(products);

    dataService.update(id: id, data: {
      "date": date.toString(),
      "client_id": clientId,
      "user_id": userId,
      "money_delivered": moneyDelivered,
      "total": total,
      "total_discount": totalDiscount,
      "products": jsonEncode(adaptedArray)
    });
  }
}
