import 'ideable.dart';

class Consumption implements Iideable {
  @override
  int id;
  int clientId;
  int serviceId;
  int userId;
  int quantity;
  String? date;

  Consumption(
      {required this.id,
      required this.clientId,
      required this.serviceId,
      required this.userId,
      required this.quantity,
      this.date});

  factory Consumption.fromJson(Map<String, dynamic> json) {
    return Consumption(
      id: json['id'],
      clientId: json['client_id'],
      serviceId: json['service_id'],
      userId: json['user_id'],
      quantity: json['quantity'],
      date: json['date'],
    );
  }
}
