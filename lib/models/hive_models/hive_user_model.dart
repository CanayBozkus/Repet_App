import 'package:hive/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class HiveUserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String nameSurname;
  @HiveField(3)
  int age;
  @HiveField(4)
  int phoneNumber;
  @HiveField(5)
  String gender;
  @HiveField(6)
  List addresses;
  @HiveField(7)
  List pets;
  @HiveField(8)
  String calendarId;

  HiveUserModel({
    this.id,
    this.gender,
    this.pets,
    this.nameSurname,
    this.email,
    this.age,
    this.addresses,
    this.phoneNumber,
    this.calendarId
  });
}
