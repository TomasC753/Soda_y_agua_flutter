// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ideable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IideableAdapter extends TypeAdapter<Iideable> {
  @override
  final int typeId = 0;

  @override
  Iideable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Iideable()..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Iideable obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IideableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
