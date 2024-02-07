// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_codes_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrCodesLocalAdapter extends TypeAdapter<QrCodesLocal> {
  @override
  final int typeId = 1;

  @override
  QrCodesLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrCodesLocal(
      qrCodes: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QrCodesLocal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.qrCodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrCodesLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
