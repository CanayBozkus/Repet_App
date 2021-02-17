import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repetapp/models/hive_models/hive_user_model.dart';
import 'package:repetapp/models/hive_models/hive_pet_model.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart';


class Database {
  Box _userModel;
  Box _petModel;
  Box _calendarModel;
  initializeDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PetModelAdapter());
    Hive.registerAdapter(CalendarModelAdapter());
    _userModel = await Hive.openBox('UserModel');
    _petModel = await Hive.openBox('PetModel');
    _calendarModel = await Hive.openBox('CalendarModel');
  }

  void addData({@required String model, @required data}){
    model = model.toLowerCase();
    if(model == 'usermodel'){
      _userModel.put(data.id, data);
    }
    else if(model == 'petmodel'){
      _petModel.put(data.id, data);
    }
    else if(model == 'calendarmodel'){
      _calendarModel.add(data);
    }
  }

  List getData({@required String model, @required value}){
    model = model.toLowerCase();
    print("inn");
    if(model == 'usermodel'){

    }
    else if(model == 'petmodel'){

    }
    else if(model == 'calendarmodel'){
      return _calendarModel.values.where((instance){
        return instance.dateTime == value;
      }).toList();
    }
  }

  List getAllCalendarEvents(){
    return _calendarModel.values.toList();
  }
}

Database databaseManager = Database();