// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveNotificationModelAdapter extends TypeAdapter<HiveNotificationModel> {
  @override
  final int typeId = 4;

  @override
  HiveNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveNotificationModel(
      id: fields[0] as int,
      name: fields[1] as String,
      userId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveNotificationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
