import 'package:cipta_cuan/app/modules/notification/notification_servies.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _notificationService.initialize(); // Inisialisasi notifikasi
  }

  void addNotification(int id, String title, String body, DateTime date) {
    _notificationService.scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: date,
    );
    notifications.add({'id': id, 'title': title, 'body': body, 'date': date});
  }

  void removeNotification(int id) {
    notifications.removeWhere((notif) => notif['id'] == id);
    // Jika ingin membatalkan notifikasi tertentu, tambahkan logika di sini
  }
}
