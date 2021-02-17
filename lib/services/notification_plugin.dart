import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;
import 'package:rxdart/subjects.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  InitializationSettings initializationSettings;
  final MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');
  NotificationPlugin._(){
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS){
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
    tz.initializeTimeZones();
    String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
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
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
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
      importance: Importance.max,
      priority: Priority.high,
      icon: 'repet_notf_icon',
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> scheduleNotification({@required id, @required title, @required body, @required payload, @required DateTime schedule}) async {
    //DO NOT USE. CHECK BEFORE
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_2',
      'REPET SCHEDULE NOTIFICATION CHANNEL',
      '',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'repet_notf_icon',
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        schedule,
        platformChannelSpecifics,
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
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
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      icon: 'repet_notf_icon',
    );
    var notificationDetails = NotificationDetails(android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: payload);
  }

  Future<void> repeatNotification({@required id, @required title, @required body, @required payload, @required repeatInterval}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_4',
      'REPET REPEAT NOTIFICATION CHANNEL',
      '',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'repet_notf_icon',
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(id, title, body, repeatInterval, platformChannelSpecifics, payload: payload);
  }

  Future<void> showDailyAtTimeNotification({@required id, @required title, @required body, @required payload, @required time}) async {
    tz.TZDateTime notificationTime = tz.TZDateTime.from(time, tz.local);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_5',
      'REPET DAILY NOTIFICATION CHANNEL',
      '',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'repet_notf_icon',
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      notificationTime,
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showWeeklyAtDayAndTimeNotification({@required id, @required title, @required body, @required payload, @required time, @required day}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'REPET_CHANNEL_6',
      'REPET WEEKLY NOTIFICATION CHANNEL',
      '',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'repet_notf_icon',
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
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