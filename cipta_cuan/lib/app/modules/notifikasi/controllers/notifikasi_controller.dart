import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Daftar notifikasi
  final notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Menambahkan notifikasi baru
  Future<void> addScheduledNotification(
      String title, String body, DateTime dateTime) async {
    final int notificationId = dateTime.millisecondsSinceEpoch ~/ 1000;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'jadwal_channel',
          'Jadwal Notifikasi',
          channelDescription: 'Pengingat untuk jadwal yang ditambahkan',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    notifications.add({
      "title": title,
      "body": body,
      "dateTime": dateTime,
    });
    update();
  }

  // Menghapus notifikasi
  void removeNotification(int index) {
    notifications.removeAt(index);
    update();
  }
}
