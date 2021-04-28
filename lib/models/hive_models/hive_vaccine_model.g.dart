// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_vaccine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveVaccineModelAdapter extends TypeAdapter<HiveVaccineModel> {
  @override
  final int typeId = 5;

  @override
  HiveVaccineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVaccineModel(
      id: fields[0] as String,
      name: fields[1] as String,
      periods: (fields[2] as Map)?.cast<String, DateTime>(),
      firstShots: (fields[3] as Map)?.cast<String, DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveVaccineModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.periods)
      ..writeByte(3)
      ..write(obj.firstShots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveVaccineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
