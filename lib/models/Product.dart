import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';

import '../services/crud_functionalities.dart';
import 'Service.dart';
import 'ideable.dart';

class Product implements Iideable {
  @override
  int id;
  String name;
  double price;
  List<Service>? services;
  Map? pivot;

  static CrudFunctionalities<Product> crudFunctionalities =
      CrudFunctionalities<Product>(
          modelName: 'product',
          pluralModelName: 'products',
          serializer: Product.fromJson);

  Product(
      {required this.id,
      required this.price,
      required this.name,
      this.services,
      this.pivot});

  factory Product.fromJson(Map<String, dynamic> json) {
    Product product = Product(
        id: json['id'],
        price: json['price'].toDouble(),
        name: json['name'],
        pivot: json['pivot']);

    isFilled(
        json['products'],
        () => {
              product.services = relateMatrixToModel<Service>(
                  data: json['products'], serializerOfModel: Service.fromJson)
            });

    return product;
  }
}
