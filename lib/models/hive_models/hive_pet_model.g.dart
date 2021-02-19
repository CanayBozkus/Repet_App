// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_pet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePetModelAdapter extends TypeAdapter<HivePetModel> {
  @override
  final int typeId = 1;

  @override
  HivePetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePetModel(
      id: fields[0] as String,
      gender: fields[5] as String,
      allergies: (fields[10] as List)?.cast<dynamic>(),
      month: fields[9] as int,
      year: fields[8] as int,
      species: fields[4] as String,
      weight: fields[6] as double,
      height: fields[7] as double,
      name: fields[2] as String,
      type: fields[3] as String,
      routines: (fields[13] as Map)?.cast<dynamic, dynamic>(),
      sicknesses: (fields[12] as List)?.cast<dynamic>(),
      disabilities: (fields[11] as List)?.cast<dynamic>(),
      ownerId: fields[1] as String,
      petTrainingModelId: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HivePetModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.species)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.year)
      ..writeByte(9)
      ..write(obj.month)
      ..writeByte(10)
      ..write(obj.allergies)
      ..writeByte(11)
      ..write(obj.disabilities)
      ..writeByte(12)
      ..write(obj.sicknesses)
      ..writeByte(13)
      ..write(obj.routines)
      ..writeByte(14)
      ..write(obj.petTrainingModelId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
