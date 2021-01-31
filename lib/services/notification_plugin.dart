import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as scheduler;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;
import 'package:rxdart/subjects.dart';
class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  var initializationSettings;
  NotificationPlugin._(){
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS){
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics(){
    var initializationSettingsAndroid = AndroidInitializationSettings('repet_notf_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      }
    );

    initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS
    );

  }

  _requestIOSPermission(){
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions){
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification({@required id, @required title, @required body, @required payload}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_1',
      'REPET NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> scheduleNotification({@required id, @required title, @required body, @required payload, @required schedule}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_2',
      'REPET SCHEDULE NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(id, title, body, schedule, platformChannelSpecifics, payload: 'test payload');
  }

  Future<void> showNotificationWithAttachment({@required id, @required title, @required body, @required payload, @required attachment, @required attachmentTitle, @required summaryText}) async {
    var iOSPlatformSpecifics = IOSNotificationDetails(
      attachments: [IOSNotificationAttachment(attachment)]
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachment),
      contentTitle: attachmentTitle,
      htmlFormatContentTitle: true,
      summaryText: summaryText,
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_3',
      'REPET ATTACHMENT NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(androidChannelSpecifics, iOSPlatformSpecifics);
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: payload);
  }

  Future<void> repeatNotification({@required id, @required title, @required body, @required payload, @required repeatInterval}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_4',
      'REPET REPEAT NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(id, title, body, repeatInterval, platformChannelSpecifics, payload: payload);
  }

  Future<void> showDailyAtTimeNotification({@required id, @required title, @required body, @required payload, @required time}) async {
    var notfTime = Time(time.hour, time.minute, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_5',
      'REPET DAILY NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(id, title, body, notfTime, platformChannelSpecifics, payload: payload);
  }

  Future<void> showWeeklyAtDayAndTimeNotification({@required id, @required title, @required body, @required payload, @required time, @required day}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_6',
      'REPET WEEKLY NOTIFICATION CHANNEL',
      '',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(id, title, body, day, time, platformChannelSpecifics, payload: payload);
  }

  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }

  Future<void> cancelNotification({@required id}) async {
    await flutterLocalNotificationsPlugin.cancel(id); //write unique id
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll(); //write unique id
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}