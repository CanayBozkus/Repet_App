import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repetapp/models/hive_models/hive_notification_model.dart';
import 'package:repetapp/models/hive_models/hive_user_model.dart';
import 'package:repetapp/models/hive_models/hive_pet_model.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';


class Database {
  Box _userModel;
  Box _petModel;
  Box _calendarModel;
  Box _notificationModel;
  initializeDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(HiveUserModelAdapter());
    Hive.registerAdapter(HivePetModelAdapter());
    Hive.registerAdapter(HiveCalendarModelAdapter());
    Hive.registerAdapter(HiveNotificationModelAdapter());
    _userModel = await Hive.openBox('UserModel');
    _petModel = await Hive.openBox('PetModel');
    _calendarModel = await Hive.openBox('CalendarModel');
    _notificationModel = await Hive.openBox('NotificationModel');
  }

  void addData({@required String model, @required data}){
    model = model.toLowerCase();
    if(model == 'usermodel'){
      _userModel.put(data.id, data);
    }
    else if(model == 'petmodel'){
      _petModel.add(data);
    }
    else if(model == 'calendarmodel'){
      _calendarModel.add(data);
    }
  }

  List getAllCalendarEvents(String userId){
    return _calendarModel.values.where((e) => e.userId == userId).toList();
  }
  
  void updateEventStatus(DateTime date, bool status){
    HiveCalendarModel model = _calendarModel.values.where((element) => element.dateTime == date).first;
    int index = _calendarModel.values.toList().indexOf(model);
    model.isDone = status;
    _calendarModel.putAt(index, model);
  }
  
  void deleteAllCalendar() async {
    await Hive.box('CalendarModel').clear();
  }

  HiveUserModel getLocalUserData(String id){
    List data = _userModel.values.where((element) => element.id == id).toList();
    if(data.isEmpty){
      return null;
    }
    return _userModel.values.where((element) => element.id == id).first;
  }

  HivePetModel getLocalPet(String id){
    List data = _petModel.values.where((element) => element.id == id).toList();
    if(data.isEmpty){
      return null;
    }
    return _petModel.values.where((element) => element.id == id).first;
  }

  bool updatePetList(String id, List pets){
    HiveUserModel model = _userModel.values.where((element) => element.id == id).first;
    int index = _userModel.values.toList().indexOf(model);
    model.pets = pets;
    _userModel.putAt(index, model);
    return true;
  }

  void updatePetRoutine(String id, Map routines){
    HivePetModel model = _petModel.values.where((element) => element.id == id).first;
    int index = _petModel.values.toList().indexOf(model);
    model.routines = routines;
    print(model.routines);
    _petModel.putAt(index, model);
  }

  int getNextNotificationId(){
    return _notificationModel.values.length;
  }

  void addNewNotification(String name, int id, String userId){
    HiveNotificationModel newNotf = HiveNotificationModel(id: id, name: name, userId: userId);
    _notificationModel.add(newNotf);
  }

  void deletePets(){
    Hive.box('PetModel').clear();
  }

  void updatePetData(String id, Map data){
    HivePetModel model = _petModel.values.where((element) => element.id == id).first;
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

  void updatePersonalData(String id, Map data){
    HiveUserModel model = _userModel.values.where((element) => element.id == id).first;
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