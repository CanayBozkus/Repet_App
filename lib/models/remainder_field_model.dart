import 'package:cloud_firestore/cloud_firestore.dart';

class RemainderFieldModel {
  DateTime time;
  bool isActive;
  int id;

  RemainderFieldModel({
    this.time,
    this.isActive,
    this.id,
  });

  Map toMap(){
    return {
      'time': this.time,
      'isActive': this.isActive,
      'id': this.id,
    };
  }

  static RemainderFieldModel fromMap({Map data, bool isLocal}){
    DateTime time;
    if(isLocal){
      time = data['time'];
    }
    else {
      Timestamp timestamp = data['time'];
      time = timestamp.toDate();
    }
    return RemainderFieldModel(
      time: time,
      isActive: data['isActive'],
      id: data['id'],
    );
  }
}