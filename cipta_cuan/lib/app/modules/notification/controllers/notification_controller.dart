import 'package:cipta_cuan/app/modules/notification/notification_servies.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  var notifications = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userId;

  NotificationController({required this.userId}) {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _notificationService.initialize(); // Inisialisasi notifikasi
    _loadNotifications();
  }

  // Memuat notifikasi dari Firestore
  void _loadNotifications() async {
    try {
      final doc = await firestore.collection('jadwal').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        notifications.value = (data['jadwal'] as List<dynamic>?)?.map((e) {
              return Map<String, dynamic>.from(e);
            }).toList() ??
            [];
      }
    } catch (e) {
      log('Error loading notifications: $e');
    }
  }

  // Menambahkan notifikasi baru
  void addNotification(int id, String title, String body, DateTime date) async {
    try {
      final newNotification = {
        'id': id,
        'title': title,
        'body': body,
        'date': date,
      };
      notifications.add(newNotification);

      await firestore.collection('jadwal').doc(userId).set({
        'jadwal': FieldValue.arrayUnion([newNotification]),
      }, SetOptions(merge: true));

      _notificationService.scheduleNotification(
        id: id,
        title: title,
        body: body,
        scheduledDate: date,
      );

      log('Notification added: $newNotification');
    } catch (e) {
      log('Error adding notification: $e');
    }
  }

  // Menghapus satu notifikasi berdasarkan ID
  void removeNotification(int id) async {
    try {
      final notificationToRemove =
          notifications.firstWhere((notif) => notif['id'] == id);
      notifications.remove(notificationToRemove);

      await firestore.collection('jadwal').doc(userId).update({
        'jadwal': FieldValue.arrayRemove([notificationToRemove]),
      });

      _notificationService.cancelNotification(id);
      log('Notification removed: $notificationToRemove');
    } catch (e) {
      log('Error removing notification: $e');
    }
  }

  // Menghapus semua notifikasi
  void clearAllNotifications() async {
    try {
      notifications.clear();

      await firestore.collection('jadwal').doc(userId).update({
        'jadwal': [],
      });

      _notificationService.cancelAllNotifications();
      log('All notifications cleared');
    } catch (e) {
      log('Error clearing all notifications: $e');
    }
  }
}
