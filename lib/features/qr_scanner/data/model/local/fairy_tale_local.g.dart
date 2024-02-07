// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fairy_tale_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FairyTaleLocalAdapter extends TypeAdapter<FairyTaleLocal> {
  @override
  final int typeId = 0;

  @override
  FairyTaleLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FairyTaleLocal(
      id: fields[0] as String,
      titles: (fields[1] as List).cast<String>(),
      titleId: fields[2] as String,
      musics: (fields[3] as List).cast<String>(),
      qrCodes: (fields[4] as List).cast<String>(),
      pics: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FairyTaleLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titles)
      ..writeByte(2)
      ..write(obj.titleId)
      ..writeByte(3)
      ..write(obj.musics)
      ..writeByte(4)
      ..write(obj.qrCodes)
      ..writeByte(5)
      ..write(obj.pics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FairyTaleLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
