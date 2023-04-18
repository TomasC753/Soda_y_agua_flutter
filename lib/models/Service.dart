import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import 'Client.dart';
import 'Product.dart';
import 'ideable.dart';

class Service implements Iideable {
  @override
  int id;
  String name;
  double price;
  List<Client>? clients;
  List<Product>? products;
  Map? pivot;

  Service(
      {required this.id,
      required this.name,
      required this.price,
      this.pivot,
      this.clients});

  factory Service.fromJson(Map<String, dynamic> json) {
    Service service = Service(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        pivot: json['pivot']);

    isFilled(
        json['clients'],
        () => {
              service.clients = relateMatrixToModel<Client>(
                  data: json['clients'], serializerOfModel: Service.fromJson)
            });

    isFilled(
        json['products'],
        () => {
              service.products = relateMatrixToModel<Product>(
                  data: json['products'], serializerOfModel: Service.fromJson)
            });

    return service;
  }
}
