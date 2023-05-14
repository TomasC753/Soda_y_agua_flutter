// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Zone.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZoneAdapter extends TypeAdapter<Zone> {
  @override
  final int typeId = 11;

  @override
  Zone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Zone(
      id: fields[0] as int,
      name: fields[1] as String,
      city: fields[2] as String,
      clients: (fields[3] as List?)?.cast<Client>(),
      users: (fields[4] as List?)?.cast<User>(),
      pivot: (fields[5] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Zone obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.clients)
      ..writeByte(4)
      ..write(obj.users)
      ..writeByte(5)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zone _$ZoneFromJson(Map<String, dynamic> json) => Zone(
      id: json['id'] as int,
      name: json['name'] as String,
      city: json['city'] as String,
      clients: (json['clients'] as List<dynamic>?)
          ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      pivot: json['pivot'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'clients': instance.clients,
      'users': instance.users,
      'pivot': instance.pivot,
    };
