import 'package:hive/hive.dart';

part 'hive_device_model.g.dart';

@HiveType(typeId: 2)
class HiveDeviceModel {
  @HiveField(0)
  String userId;
  @HiveField(1)
  int availableNotificationId;

  HiveDeviceModel({
    this.availableNotificationId = 0,
    this.userId,
  });
}
