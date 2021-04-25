// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDeviceModelAdapter extends TypeAdapter<HiveDeviceModel> {
  @override
  final int typeId = 2;

  @override
  HiveDeviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDeviceModel(
      availableNotificationId: fields[1] as int,
      userId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDeviceModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.availableNotificationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
