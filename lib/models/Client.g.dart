// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Client.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 1;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      id: fields[0] as int,
      name: fields[1] as String,
      lastName: fields[2] as String,
      domicile: fields[3] as String,
      phoneNumber: fields[4] as String?,
      clientNumber: fields[5] as String?,
      limitsAndConsumptions: (fields[11] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, int>())),
      debtState: fields[6] as int,
      pivot: (fields[14] as Map?)?.cast<dynamic, dynamic>(),
      zoneId: fields[7] as int,
    )
      ..services = (fields[8] as List?)?.cast<Service>()
      ..consumptions = (fields[9] as List?)?.cast<Consumption>()
      ..productPrices = (fields[10] as List?)?.cast<ProductPrice>()
      ..purchases = (fields[12] as List?)?.cast<Sale>()
      ..zone = fields[13] as Zone?;
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.domicile)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.clientNumber)
      ..writeByte(6)
      ..write(obj.debtState)
      ..writeByte(7)
      ..write(obj.zoneId)
      ..writeByte(8)
      ..write(obj.services)
      ..writeByte(9)
      ..write(obj.consumptions)
      ..writeByte(10)
      ..write(obj.productPrices)
      ..writeByte(11)
      ..write(obj.limitsAndConsumptions)
      ..writeByte(12)
      ..write(obj.purchases)
      ..writeByte(13)
      ..write(obj.zone)
      ..writeByte(14)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      domicile: json['domicile'] as String,
      phoneNumber: json['phone_number'] as String?,
      clientNumber: json['client_number'] as String?,
      limitsAndConsumptions: Client.limitsAndConsumptionsFromJson(
          json['limits_and_consumptions'] as Map<String, dynamic>?),
      debtState: json['debt_state'] as int? ?? 0,
      pivot: json['pivot'] as Map<String, dynamic>?,
      zoneId: json['zone_id'] as int,
    )
      ..services = (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList()
      ..consumptions = (json['last_month_consumptions'] as List<dynamic>?)
          ?.map((e) => Consumption.fromJson(e as Map<String, dynamic>))
          .toList()
      ..productPrices = (json['discount_products'] as List<dynamic>?)
          ?.map((e) => ProductPrice.fromJson(e as Map<String, dynamic>))
          .toList()
      ..purchases = (json['purchases'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList()
      ..zone = json['zone'] == null
          ? null
          : Zone.fromJson(json['zone'] as Map<String, dynamic>);

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'domicile': instance.domicile,
      'phone_number': instance.phoneNumber,
      'client_number': instance.clientNumber,
      'debt_state': instance.debtState,
      'zone_id': instance.zoneId,
      'services': instance.services,
      'last_month_consumptions': instance.consumptions,
      'discount_products': instance.productPrices,
      'limits_and_consumptions':
          Client.limitsAndConsumptionsToJson(instance.limitsAndConsumptions),
      'purchases': instance.purchases,
      'zone': instance.zone,
      'pivot': instance.pivot,
    };
