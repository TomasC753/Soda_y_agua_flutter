import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';
import 'package:hive/hive.dart';

import 'Service.dart';
import 'ideable.dart';

part 'Product.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class Product implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  List<Service>? services;

  @HiveField(4)
  Map? pivot;

  static var dataService = DataService<Product>(
      pluralModelName: 'products',
      singularModelName: 'product',
      serializer: Product.fromJson);

  Product(
      {required this.id,
      required this.price,
      required this.name,
      this.services,
      this.pivot});

  // factory Product.fromJson(Map<dynamic, dynamic> json) {
  //   Product product = Product(
  //       id: json['id'],
  //       price: json['price'].toDouble(),
  //       name: json['name'],
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['products'],
  //       () => {
  //             product.services = relateMatrixToModel<Service>(
  //                 data: json['products'], serializerOfModel: Service.fromJson)
  //           });

  //   return product;
  // }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
