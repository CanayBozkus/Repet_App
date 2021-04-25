import 'package:hive/hive.dart';

part 'hive_device_model.g.dart';

@HiveType(typeId: 2)
class HiveDeviceModel {
  @HiveField(0)
  int availableNotificationId;

}