import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarModel {
  CalendarModel(){
    _fireStore = FirebaseFirestore.instance;
  }

  String id;
  String userId;
  List eventCollections;
  FirebaseFirestore _fireStore;

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

  void addEvent(){

  }
  
  Future<bool> getCalendarData(documentId) async {
    final calendar = await _fireStore.collection('CalendarModel').doc(documentId).get();
    final data = calendar.data();
    id = data['id'];
    userId = data['user_id'];
    eventCollections = data['event_collections'];
    return true;
  }
}