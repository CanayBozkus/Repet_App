// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserModelAdapter extends TypeAdapter<HiveUserModel> {
  @override
  final int typeId = 0;

  @override
  HiveUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUserModel(
      id: fields[0] as String,
      gender: fields[5] as String,
      pets: (fields[7] as List)?.cast<dynamic>(),
      nameSurname: fields[2] as String,
      email: fields[1] as String,
      age: fields[3] as int,
      addresses: (fields[6] as List)?.cast<dynamic>(),
      phoneNumber: fields[4] as int,
      calendarId: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.nameSurname)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.addresses)
      ..writeByte(7)
      ..write(obj.pets)
      ..writeByte(8)
      ..write(obj.calendarId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
