import 'package:hive/hive.dart';

part 'hive_pet_model.g.dart';

@HiveType(typeId: 1)
class PetModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String ownerId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final String species;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final double weight;
  @HiveField(7)
  final double height;
  @HiveField(8)
  final int year;
  @HiveField(9)
  final int month;
  @HiveField(10)
  final List allergies;
  @HiveField(11)
  final List disabilities;
  @HiveField(12)
  final List sicknesses;
  @HiveField(13)
  final Map routines;
  @HiveField(14)
  final int petTrainingModelId;

  PetModel({
    this.id,
    this.gender,
    this.allergies,
    this.month,
    this.year,
    this.species,
    this.weight,
    this.height,
    this.name,
    this.type,
    this.routines,
    this.sicknesses,
    this.disabilities,
    this.ownerId,
    this.petTrainingModelId,
  });
}