// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_calendar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCalendarModelAdapter extends TypeAdapter<HiveCalendarModel> {
  @override
  final int typeId = 3;

  @override
  HiveCalendarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCalendarModel(
      dateTime: fields[0] as DateTime,
      event: fields[1] as String,
      isDone: fields[2] as bool,
      userId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCalendarModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.event)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCalendarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
