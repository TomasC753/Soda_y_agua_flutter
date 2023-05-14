import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ProductPrice {
  @JsonKey(name: 'product_id')
  int productId;
  @JsonKey(name: 'service_id')
  int serviceId;
  double price;
  @JsonKey(name: 'quantity')
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
