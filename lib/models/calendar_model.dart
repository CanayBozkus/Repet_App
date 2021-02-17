import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart' as hiveCalendar;
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
    hiveCalendar.CalendarModel calendarEvent = hiveCalendar.CalendarModel(dateTime: eventDate, event: event, isDone: false);
    databaseManager.addData(model: 'calendarmodel', data: calendarEvent);
    DateTime date = DateTime(eventDate.year, eventDate.month, eventDate.day, 0, 0, 0);
    if(eventCollections.keys.contains(date)){
      eventCollections[date].add({'date': eventDate, 'event': event, 'isDone': false});
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
    List dataList = databaseManager.getAllCalendarEvents();
    dataList.forEach((element) {
      DateTime date = DateTime(element.dateTime.year, element.dateTime.month, element.dateTime.day, 0, 0, 0);
      if(eventCollections.keys.contains(date)){
        eventCollections[date].add({'date': element.dateTime, 'event': element.event, 'isDone': element.isDone});
      }
      else{
        eventCollections[date] = [{'date': element.dateTime, 'event': element.event, 'isDone': element.isDone}];
      }
      this.isDataFetch = true;
    });
    print(eventCollections);
  }
}