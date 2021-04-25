import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repetapp/models/hive_models/hive_notification_model.dart';
import 'package:repetapp/models/hive_models/hive_user_model.dart';
import 'package:repetapp/models/hive_models/hive_pet_model.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart';
import 'package:repetapp/models/hive_models/hive_device_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';

class Database {
  Box _userModel;
  Box _petModel;
  Box _calendarModel;
  Box _notificationModel;
  Box _deviceModel;
  initializeDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(HiveUserModelAdapter());
    Hive.registerAdapter(HivePetModelAdapter());
    Hive.registerAdapter(HiveCalendarModelAdapter());
    Hive.registerAdapter(HiveNotificationModelAdapter());
    Hive.registerAdapter(HiveDeviceModelAdapter());
    _userModel = await Hive.openBox('UserModel');
    _petModel = await Hive.openBox('PetModel');
    _calendarModel = await Hive.openBox('CalendarModel');
    _notificationModel = await Hive.openBox('NotificationModel');
    _deviceModel = await Hive.openBox('DeviceModel');
  }

  void addData({@required String model, @required data}) {
    model = model.toLowerCase();
    if (model == 'usermodel') {
      _userModel.put(data.id, data);
    } else if (model == 'petmodel') {
      _petModel.add(data);
    } else if (model == 'calendarmodel') {
      _calendarModel.add(data);
    } else if (model == 'devicemodel') {
      _deviceModel.add(data);
    }
  }

  void removeEvent({@required String uid, @required String event}) {
    int index = _calendarModel.values.toList().indexWhere(
        (element) => (element.userId == uid && element.event == event));
    _calendarModel.deleteAt(index);
  }

  void updateEvent({
    @required String uid,
    @required String prevEvent,
    @required String newEvent,
    @required DateTime newDate,
  }) {
    int index = _calendarModel.values.toList().indexWhere(
        (element) => (element.userId == uid && element.event == prevEvent));
    HiveCalendarModel newModel = HiveCalendarModel(
        dateTime: newDate,
        event: newEvent,
        userId: uid,
        isDone: _calendarModel.values.toList()[index].isDone);
    _calendarModel.putAt(index, newModel);
  }

  List getAllCalendarEvents(String userId) {
    return _calendarModel.values.where((e) => e.userId == userId).toList();
  }

  void updateEventStatus(DateTime date, bool status) {
    HiveCalendarModel model = _calendarModel.values
        .where((element) => element.dateTime == date)
        .first;
    int index = _calendarModel.values.toList().indexOf(model);
    model.isDone = status;
    _calendarModel.putAt(index, model);
  }

  void deleteAllCalendar() async {
    await Hive.box('CalendarModel').clear();
  }

  HiveUserModel getLocalUserData(String id) {
    List data = _userModel.values.where((element) => element.id == id).toList();
    if (data.isEmpty) {
      return null;
    }
    return _userModel.values.where((element) => element.id == id).first;
  }

  HivePetModel getLocalPet(String id) {
    List data = _petModel.values.where((element) => element.id == id).toList();
    if (data.isEmpty) {
      return null;
    }
    return _petModel.values.where((element) => element.id == id).first;
  }

  bool updatePetList(String id, List pets) {
    HiveUserModel model =
        _userModel.values.where((element) => element.id == id).first;
    int index = _userModel.values.toList().indexOf(model);
    model.pets = pets;
    _userModel.putAt(index, model);
    return true;
  }

  void updatePetRoutine(String id, Map routines) {
    HivePetModel model =
        _petModel.values.where((element) => element.id == id).first;
    int index = _petModel.values.toList().indexOf(model);
    model.routines = routines;
    print(model.routines);
    _petModel.putAt(index, model);
  }

  int getNextNotificationId(String userId) {
    HiveDeviceModel deviceData = _deviceModel.values
        .toList()
        .firstWhere((element) => element.userId == userId);
    return deviceData.availableNotificationId;
    // return _notificationModel.values.length;
  }

  void addNewNotification(String name, int id, String userId) {
    HiveNotificationModel newNotf =
        HiveNotificationModel(id: id, name: name, userId: userId);
    _notificationModel.add(newNotf);

    int deviceIndex = _deviceModel.values
        .toList()
        .indexWhere((element) => element.userId == userId);
    HiveDeviceModel device = _deviceModel.getAt(deviceIndex);
    device.availableNotificationId += 1;
    _deviceModel.putAt(deviceIndex, device);
    print(device.availableNotificationId);
  }

  // Dont know if this will work ... DO NOT TRY AT HOME
  void removeNotification(String userId, int id) {
    int index = _notificationModel.values
        .toList()
        .indexWhere((value) => value.id == id);
    this._notificationModel.deleteAt(index);

    int deviceIndex = _deviceModel.values
        .toList()
        .indexWhere((element) => element.userId == userId);
    HiveDeviceModel device = _deviceModel.getAt(deviceIndex);
    device.availableNotificationId -= 1;
    _deviceModel.putAt(deviceIndex, device);
    print(device.availableNotificationId);
  }

  void deletePets() {
    Hive.box('PetModel').clear();
  }

  void updatePetData(String id, Map data) {
    HivePetModel model =
        _petModel.values.where((element) => element.id == id).first;
    int index = _petModel.values.toList().indexOf(model);
    model.name = data['name'] ?? model.name;
    model.species = data['species'] ?? model.species;
    model.gender = data['gender'] ?? model.gender;
    model.month = data['month'] ?? model.month;
    model.year = data['year'] ?? model.year;
    model.height = data['height'] ?? model.height;
    model.weight = data['weight'] ?? model.weight;
    model.disabilities = data['disabilities'] ?? model.disabilities;
    model.allergies = data['allergies'] ?? model.allergies;
    _petModel.putAt(index, model);
  }

  void updatePersonalData(String id, Map data) {
    HiveUserModel model =
        _userModel.values.where((element) => element.id == id).first;
    int index = _userModel.values.toList().indexOf(model);
    model.email = data['email'] ?? model.email;
    model.gender = data['gender'] ?? model.gender;
    model.age = data['age'] ?? model.age;
    model.addresses = data['addresses'] ?? model.addresses;
    model.phoneNumber = data['phoneNumber'] ?? model.phoneNumber;
    model.nameSurname = data['nameSurname'] ?? model.nameSurname;
    _userModel.putAt(index, model);
  }
}

Database databaseManager = Database();
