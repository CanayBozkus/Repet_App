import 'package:hive/hive.dart';

part 'hive_calendar_model.g.dart';

@HiveType(typeId: 3)
class HiveCalendarModel { 
  @HiveField(0)
  final DateTime dateTime;
  @HiveField(1)
  final String event;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  final String userId;


  HiveCalendarModel({
    this.dateTime,
    this.event,
    this.isDone = false,
    this.userId,
  });
}