import 'package:hive/hive.dart';

part 'hive_vaccine_model.g.dart';

@HiveType(typeId: 5)
class HiveVaccineModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  Map<String, DateTime> periods;
  @HiveField(3)
  Map<String, DateTime> firstShots;

  HiveVaccineModel({
    this.id,
    this.name,
    this.periods,
    this.firstShots,
  });
}
