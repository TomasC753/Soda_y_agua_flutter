import 'package:json_annotation/json_annotation.dart';
import 'package:soda_y_agua_flutter/services/connection/api/crud_operations.dart';
import 'package:soda_y_agua_flutter/services/connection/data_service.dart';
import 'package:soda_y_agua_flutter/utils/IsFilled.dart';
import 'package:soda_y_agua_flutter/utils/modelMatcher.dart';
import 'package:hive/hive.dart';

import 'Client.dart';
import 'Product.dart';
import 'ideable.dart';

part 'Service.g.dart';

@HiveType(typeId: 9)
@JsonSerializable()
class Service implements Iideable {
  @override
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  List<Client>? clients;

  @HiveField(4)
  List<Product>? products;

  @HiveField(5)
  Map? pivot;

  static var dataService = DataService<Service>(
      pluralModelName: 'services',
      singularModelName: 'service',
      serializer: Service.fromJson);

  Service(
      {required this.id,
      required this.name,
      required this.price,
      this.pivot,
      this.clients});

  // factory Service.fromJson(Map<dynamic, dynamic> json) {
  //   Service service = Service(
  //       id: json['id'],
  //       name: json['name'],
  //       price: json['price'].toDouble(),
  //       pivot: json['pivot']);

  //   isFilled(
  //       json['clients'],
  //       () => {
  //             service.clients = relateMatrixToModel<Client>(
  //                 data: json['clients'], serializerOfModel: Client.fromJson)
  //           });

  //   isFilled(
  //       json['products'],
  //       () => {
  //             service.products = relateMatrixToModel<Product>(
  //                 data: json['products'], serializerOfModel: Product.fromJson)
  //           });

  //   return service;
  // }

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
