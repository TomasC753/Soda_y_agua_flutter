import 'dart:convert';

import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';

import '../utils/modelMatcher.dart';
import 'Client.dart';
import 'Product.dart';
import 'ideable.dart';

class Sale implements Iideable {
  @override
  int id;
  String date;
  int paidState;
  String? paidDate;
  int clientId;
  int userId;
  Client? client;
  double moneyDelivered;
  double totalDiscount;
  double total;
  int? invoiceId;
  List<Product>? products;
  Map? pivot;

  static CrudFunctionalities<Sale> crudFunctionalities =
      CrudFunctionalities<Sale>(
          modelName: 'sale',
          pluralModelName: 'sales',
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

  factory Sale.fromJson(Map<String, dynamic> json) {
    Sale sale = Sale(
        id: json['id'],
        date: json['date'],
        paidState: json['paid_state'],
        paidDate: json['paid_date'],
        clientId: json['client_id'],
        userId: json['user_id'],
        invoiceId: json['invoice_id'],
        moneyDelivered: json['money_delivered'].toDouble(),
        totalDiscount: json['total_discount'].toDouble(),
        total: json['total'].toDouble(),
        pivot: json['pivot']);

    isFilled(
        json['products'],
        () => {
              sale.products = relateMatrixToModel<Product>(
                  data: json['products'], serializerOfModel: Product.fromJson)
            });

    isFilled(
        json['client'],
        () => {
              sale.client = relateToModel(
                  data: json['client'], serializerOfModel: Client.fromJson)
            });

    return sale;
  }

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
    crudFunctionalities.store({
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
    crudFunctionalities.destroy(id);
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

    crudFunctionalities.update(id: id, data: {
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
