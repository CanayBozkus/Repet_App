import 'package:hive/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String nameSurname;
  @HiveField(3)
  final int age;
  @HiveField(4)
  final int phoneNumber;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final List addresses;
  @HiveField(7)
  final List pets;
  @HiveField(8)
  final String calendarId;
  @HiveField(9)
  final Map currentNotifications;

  UserModel({
    this.id,
    this.gender,
    this.pets,
    this.currentNotifications,
    this.nameSurname,
    this.email,
    this.age,
    this.addresses,
    this.phoneNumber,
    this.calendarId
  });
}
