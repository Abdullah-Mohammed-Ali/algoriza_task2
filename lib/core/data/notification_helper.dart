import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tzz;
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';

class NotificationHelper {
  final notification = FlutterLocalNotificationsPlugin();
  NotificationHelper(notification);
  Future initNotifications() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    await notification.initialize(
      settings,
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'event id',
        'event notification',
        importance: Importance.max,
        priority: Priority.max,
      ),
    );
  }

  Future notify({
    required int id,
    required title,
    required body,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    DateTime notificationDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    tzz.TZDateTime dates;
    if (notificationDateTime.isBefore(DateTime.now())) {
      dates = tzz.TZDateTime.from(notificationDateTime, tzz.local)
          .add(const Duration(days: 1));
    } else {
      dates = tzz.TZDateTime.from(notificationDateTime, tzz.local);
    }
    await notification.zonedSchedule(
        id, title, body, dates, notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  Future notifyInstance({
    required TaskEntity task,
  }) async {
    await notification.show(1, task.title, '', notificationDetails());
  }
}
