import 'package:hive/hive.dart';

part 'hive_notification_model.g.dart';

@HiveType(typeId: 4)
class HiveNotificationModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String userId;

  HiveNotificationModel({
    this.id,
    this.name,
    this.userId,
  });
}