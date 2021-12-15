import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  int _id = 0;

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotifications(
    String title,
    String description,
  ) async {
    _id++;
    AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails(
      _id.toString(),
      'tomafoco',
      channelDescription: 'tomafoco',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: false,
      presentSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: _androidNotificationDetails,
      iOS: _iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      _id,
      title,
      description,
      platformChannelSpecifics,
    );
  }
}
