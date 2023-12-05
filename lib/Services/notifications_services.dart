import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _configureLocalTimezone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
     requestSoundPermission: true,
     
   
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
      print('User tapped on notification with payload:');
      },
    );
  }



  Future<void> scheduleNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
  required DateTime scheduledNotificationDateTime,
}) async {
  tz.initializeTimeZones();

  try {
    final tz.TZDateTime scheduledTime = _scheduleDaily(scheduledNotificationDateTime);
    
    print('Scheduled Time: $scheduledTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('Scheduled Notification: $id - $title - $body');
  } catch (e) {
    print('Error scheduling notification: $e');
  }
}

  tz.TZDateTime _scheduleDaily(DateTime scheduledTime) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDateTime = tz.TZDateTime(tz.local, scheduledTime.year,
        scheduledTime.month, scheduledTime.day, scheduledTime.hour,
        scheduledTime.minute, scheduledTime.second);

  return scheduledDateTime.isBefore(now)
      ? scheduledDateTime.add(Duration(days: 1))
      : scheduledDateTime;
  }
  
  tz.TZDateTime _convertTime(int hour, int minutes){
    final tz.TZDateTime now= tz.TZDateTime.now(tz.local);
    tz.TZDateTime sheduleDate=
   tz.TZDateTime(tz.local, now.year, now.month, now.day,hour,minutes);
   if(sheduleDate.isBefore(now)){
    sheduleDate= sheduleDate.add(const Duration(days:1));
   }
   return sheduleDate;
  }

Future<void> _configureLocalTimezone() async {
  tz.initializeTimeZones();

  try {
    final DateTime now = DateTime.now();
    final Duration offset = now.timeZoneOffset;

    final tz.Location localLocation = tz.Location(
      'local',
      <int>[offset.inMinutes, 0],  // TransitionAt
      <int>[offset.inMinutes, 0],  // TransitionZone
      <tz.TimeZone>[],
    );

    tz.setLocalLocation(localLocation);

    print('Local timezone configured successfully.');
  } catch (e) {
    print('Error configuring local timezone: $e');
  }
}








  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      //matchDateTimeComponents:DateTimeComponents.time

      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
