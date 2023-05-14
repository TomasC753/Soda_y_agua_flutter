// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Sale.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleAdapter extends TypeAdapter<Sale> {
  @override
  final int typeId = 8;

  @override
  Sale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sale(
      id: fields[0] as int,
      date: fields[1] as String,
      paidState: fields[2] as int,
      paidDate: fields[3] as String?,
      clientId: fields[4] as int,
      userId: fields[5] as int,
      client: fields[6] as Client?,
      invoiceId: fields[10] as int?,
      moneyDelivered: fields[7] as double,
      totalDiscount: fields[8] as double,
      total: fields[9] as double,
      products: (fields[11] as List?)?.cast<Product>(),
      pivot: (fields[12] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Sale obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.paidState)
      ..writeByte(3)
      ..write(obj.paidDate)
      ..writeByte(4)
      ..write(obj.clientId)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.client)
      ..writeByte(7)
      ..write(obj.moneyDelivered)
      ..writeByte(8)
      ..write(obj.totalDiscount)
      ..writeByte(9)
      ..write(obj.total)
      ..writeByte(10)
      ..write(obj.invoiceId)
      ..writeByte(11)
      ..write(obj.products)
      ..writeByte(12)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      id: json['id'] as int,
      date: json['date'] as String,
      paidState: json['paid_state'] as int,
      paidDate: json['paid_date'] as String?,
      clientId: json['client_id'] as int,
      userId: json['user_id'] as int,
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      invoiceId: json['invoice_id'] as int?,
      moneyDelivered: (json['money_delivered'] as num).toDouble(),
      totalDiscount: (json['total_discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      pivot: json['pivot'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'paid_state': instance.paidState,
      'paid_date': instance.paidDate,
      'client_id': instance.clientId,
      'user_id': instance.userId,
      'client': instance.client,
      'money_delivered': instance.moneyDelivered,
      'total_discount': instance.totalDiscount,
      'total': instance.total,
      'invoice_id': instance.invoiceId,
      'products': instance.products,
      'pivot': instance.pivot,
    };
