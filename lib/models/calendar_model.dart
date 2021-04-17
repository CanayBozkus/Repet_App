import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/models/hive_models/hive_calendar_model.dart';

class CalendarModel {
  CalendarModel() {
    _fireStore = FirebaseFirestore.instance;
  }

  String id; // Calendar id
  String userId; // Firebase uid of the client.
  Map<DateTime, List<dynamic>> eventCollections = {};
  FirebaseFirestore _fireStore;
  bool isDataFetch = false;

  static Future<String> createCalendar(id) async {
    /*
      Future<String> calendarId = createCalendar(id)
        Creates an empty calendar with [id] for the client.
        
        Parameters
          String id: id that newly created calendar will have.
        Return
          Future<String> calendarId: A future that resolves into a string that
          contains the id of the created calendar once the calendar is stored in
          firebase cloud database.
    */

    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    DocumentReference newDocument =
        await _fireStore.collection('CalendarModel').doc(id);
    await newDocument.set({
      'id': id,
      'user_id': id,
      'event_collections': [],
    });
    return id;
  }

  void addEvent(String event, DateTime eventDate) {
    /*
      addEvent(String event, DateTime eventDate)
        Adds a new event to the local database (hive).
        
        Parameters
          String event: Title of the task.
          DateTime eventDate: The date when the event needs to occur.
        
        Return
          None
    */

    HiveCalendarModel calendarEvent = HiveCalendarModel(
        dateTime: eventDate, event: event, isDone: false, userId: this.userId);
    databaseManager.addData(model: 'calendarmodel', data: calendarEvent);
    DateTime date =
        DateTime(eventDate.year, eventDate.month, eventDate.day, 0, 0, 0);
    if (eventCollections.keys.contains(date)) {
      eventCollections[date]
          .add({'date': eventDate, 'event': event, 'isDone': false});
    } else {
      eventCollections[date] = [
        {'date': eventDate, 'event': event, 'isDone': false}
      ];
    }
  }

  void removeEvent(String event, DateTime key) {
    // Remove from local database
    databaseManager.removeEvent(
      uid: this.userId,
      event: event,
    );
    // Remove from RAM
    if (eventCollections.keys.contains(key)) {
      eventCollections[key]
          .removeWhere((element) => (element["event"] == event));
    }
  }

  void updateEvent({String prevEvent, String newEvent, DateTime newDate}) {
    DateTime key = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      0,
      0,
      0,
    );
    if (eventCollections.keys.contains(key)) {
      int index = eventCollections[key]
          .indexWhere((element) => element["event"] == prevEvent);

      if (eventCollections[key][index] ==
          {
            "date": newDate,
            "event": newEvent,
            "isDone": eventCollections[key][index]["isDone"]
          }) {
        return;
      }

      // Update the data in database
      databaseManager.updateEvent(
        uid: this.userId,
        prevEvent: prevEvent,
        newEvent: newEvent,
        newDate: newDate,
      );
      // Upaate the data in RAM
      eventCollections[key][index] = {
        "date": newDate,
        "event": newEvent,
        "isDone": eventCollections[key][index]["isDone"],
      };
    }
  }

  @deprecated
  Future<bool> getCalendarData(documentId) async {
    //DO NOT use this function
    final calendar =
        await _fireStore.collection('CalendarModel').doc(documentId).get();
    final data = calendar.data();
    id = data['id'];
    userId = data['user_id'];
    eventCollections = data['event_collections'];
    this.isDataFetch = true;

    return true;
  }

  void getLocalCalendarData() {
    /*
      getLocalCalendarData()
        Gets all the events associated with the client.
        
        Parameters
          String event: Title of the task.
          DateTime eventDate: The date when the event needs to occur.
        
        Return
          None
    */

    List dataList = databaseManager.getAllCalendarEvents(this.userId);
    dataList.forEach((element) {
      DateTime date = DateTime(element.dateTime.year, element.dateTime.month,
          element.dateTime.day, 0, 0, 0); // DateTime object of the current day.
      // if there is events scheduled for today registered already,
      // add the current element to that list.
      if (eventCollections.keys.contains(date)) {
        eventCollections[date].add({
          'date': element.dateTime,
          'event': element.event,
          'isDone': element.isDone
        });
      }
      // else, create a new subcollection for today and add the current element
      // to that container as the first element.
      else {
        eventCollections[date] = [
          {
            'date': element.dateTime,
            'event': element.event,
            'isDone': element.isDone
          }
        ];
      }
      this.isDataFetch = true;
    });
  }

  void updateStatus(DateTime date, bool status) {
    /*
      getLocalCalendarData()
        Updates the status of an event with [date] to [status]
        
        Parameters
          DateTime date: Date of the event.
          bool status: The date when the event needs to occur.
        
        Return
          None
    */
    databaseManager.updateEventStatus(date, status);
    DateTime eventDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    eventCollections[eventDay].forEach((element) {
      if (element['date'] == date) {
        element['isDone'] = status;
      }
    });
  }
}
