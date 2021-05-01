import 'package:hive/hive.dart';

part 'hive_pet_model.g.dart';

@HiveType(typeId: 1)
class HivePetModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String ownerId;
  @HiveField(2)
  String name;
  @HiveField(3)
  String type;
  @HiveField(4)
  String species;
  @HiveField(5)
  String gender;
  @HiveField(6)
  double weight;
  @HiveField(7)
  double height;
  @HiveField(8)
  int year;
  @HiveField(9)
  int month;
  @HiveField(10)
  List allergies;
  @HiveField(11)
  List disabilities;
  @HiveField(12)
  List sicknesses;
  @HiveField(13)
  Map routines;
  @HiveField(14)
  int petTrainingModelId;
  @HiveField(15)
  Map<String, DateTime> trackedVaccines;

  HivePetModel({
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
    this.trackedVaccines,
  });
}
