// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 9;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      id: fields[0] as int,
      name: fields[1] as String,
      price: fields[2] as double,
      pivot: (fields[5] as Map?)?.cast<dynamic, dynamic>(),
      clients: (fields[3] as List?)?.cast<Client>(),
    )..products = (fields[4] as List?)?.cast<Product>();
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.clients)
      ..writeByte(4)
      ..write(obj.products)
      ..writeByte(5)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      pivot: json['pivot'] as Map<String, dynamic>?,
      clients: (json['clients'] as List<dynamic>?)
          ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..products = (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'clients': instance.clients,
      'products': instance.products,
      'pivot': instance.pivot,
    };
