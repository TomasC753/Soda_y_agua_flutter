// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Consumption.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumptionAdapter extends TypeAdapter<Consumption> {
  @override
  final int typeId = 3;

  @override
  Consumption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Consumption(
      id: fields[0] as int,
      clientId: fields[1] as int,
      serviceId: fields[2] as int,
      userId: fields[4] as int,
      productId: fields[3] as int,
      quantity: fields[5] as int,
      date: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Consumption obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clientId)
      ..writeByte(2)
      ..write(obj.serviceId)
      ..writeByte(3)
      ..write(obj.productId)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consumption _$ConsumptionFromJson(Map<String, dynamic> json) => Consumption(
      id: json['id'] as int,
      clientId: json['client_id'] as int,
      serviceId: json['service_id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ConsumptionToJson(Consumption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'service_id': instance.serviceId,
      'product_id': instance.productId,
      'user_id': instance.userId,
      'quantity': instance.quantity,
      'date': instance.date,
    };
