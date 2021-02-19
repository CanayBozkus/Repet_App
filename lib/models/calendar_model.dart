import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart';
class CalendarModel {
  CalendarModel(){
    _fireStore = FirebaseFirestore.instance;
  }

  String id;
  String userId;
  Map<DateTime, List<dynamic>> eventCollections = {};
  FirebaseFirestore _fireStore;
  bool isDataFetch = false;

  static Future<String> createCalendar(id) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    DocumentReference newDocument = await _fireStore.collection('CalendarModel').doc(id);
    await newDocument.set({
      'id': id,
      'user_id': id,
      'event_collections': []
    });
    return id;
  }

  void addEvent(String event, DateTime eventDate){
    HiveCalendarModel calendarEvent = HiveCalendarModel(dateTime: eventDate, event: event, isDone: false, userId: this.userId);
    databaseManager.addData(model: 'calendarmodel', data: calendarEvent);
    DateTime date = DateTime(eventDate.year, eventDate.month, eventDate.day, 0, 0, 0);
    if(eventCollections.keys.contains(date)){
      eventCollections[date].add({'date': eventDate, 'event': event, 'isDone': false});
    }
    else {
      eventCollections[date] =[{'date': eventDate, 'event': event, 'isDone': false}];
    }
  }
  @deprecated
  Future<bool> getCalendarData(documentId) async {
    //DO NOT use this function
    final calendar = await _fireStore.collection('CalendarModel').doc(documentId).get();
    final data = calendar.data();
    id = data['id'];
    userId = data['user_id'];
    eventCollections = data['event_collections'];
    this.isDataFetch = true;

    return true;
  }

  void getLocalCalendarData(){
    print(1);
    List dataList = databaseManager.getAllCalendarEvents(this.userId);
    print(1);
    print(dataList);
    dataList.forEach((element) {
      DateTime date = DateTime(element.dateTime.year, element.dateTime.month, element.dateTime.day, 0, 0, 0);
      print(2);
      if(eventCollections.keys.contains(date)){
        eventCollections[date].add({'date': element.dateTime, 'event': element.event, 'isDone': element.isDone});
      }
      else{
        eventCollections[date] = [{'date': element.dateTime, 'event': element.event, 'isDone': element.isDone}];
      }
      print(2);
      this.isDataFetch = true;
    });
    print(1);
    print(eventCollections);
  }

  void updateStatus(DateTime date, bool status){
    databaseManager.updateEventStatus(date, status);
    DateTime eventDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    eventCollections[eventDay].forEach((element){
      if(element['date'] == date){
        element['isDone'] = status;
      }
    });
  }
}