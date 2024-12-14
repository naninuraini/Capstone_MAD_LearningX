import 'dart:developer';

import 'package:cipta_cuan/widget/notification_servies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../models/jadwal/jadwal_entity.dart';
import '../../../../models/jadwal/jadwal_model.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var allJadwal = <Jadwal>[].obs;
  var notifications = <Map<String, dynamic>>[].obs;
  RxSet<Jadwal> selectedForDeletion = <Jadwal>{}.obs;
  var isLoading = false.obs;

  Future<void> getJadwal(String userId) async {
    try {
      isLoading.value = true;
      List<Jadwal> fetchedPosts = [];
      final snapshot = await _firestore.collection('jadwal').doc(userId).get();
      if (snapshot.data() != null) {
        final data = snapshot.data()![userId] as List<dynamic>;
        for (var postData in data) {
          JadwalEntity entity = JadwalEntity.fromDocument(postData);
          fetchedPosts.add(Jadwal.fromEntity(entity));
        }
      }
      allJadwal.value = fetchedPosts;
      isLoading.value = false;
    } catch (e) {
      log("Error fetching schedules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(Jadwal jadwal) {
    if (selectedForDeletion.contains(jadwal)) {
      selectedForDeletion.remove(jadwal);
    } else {
      selectedForDeletion.add(jadwal);
    }
  }

  void deleteSelected() async {
    try {
      for (var jadwal in selectedForDeletion) {
        var data = _firestore.collection('jadwal').doc(jadwal.myUser.id);
        if (allJadwal.length == 1) {
          await data.delete();
          _notificationService.cancelAllNotifications();
        } else {
          await data.update({
            jadwal.myUser.id:
                FieldValue.arrayRemove([jadwal.toEntity().toDocument()])
          });
          log("hashcode notif: ${jadwal.jadwalId.hashCode}");
          _notificationService.cancelNotification(jadwal.jadwalId.hashCode);
        }
      }
      allJadwal.removeWhere((jadwal) => selectedForDeletion.contains(jadwal));
      selectedForDeletion.clear();

      log("Selected schedules deleted successfully.");
    } catch (e) {
      log("Error deleting selected schedules: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    selectedForDeletion.clear();
  }
}
