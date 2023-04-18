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
}
