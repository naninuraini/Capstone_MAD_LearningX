import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/jadwal/jadwal_entity.dart';
import '../../../../models/jadwal/jadwal_model.dart';

class SchedulingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime selectedTanggal = DateTime.now().toLocal();
  var wantDelete = false.obs;
  RxSet<Jadwal> selectedForDeletion = <Jadwal>{}.obs;
  var selectedJadwal = <Jadwal>[].obs;

  Future<void> getJadwal(String userId, DateTime select) async {
    try {
      List<Jadwal> fetchedPosts = [];
      final snapshot = await _firestore.collection('jadwal').doc(userId).get();
      if (snapshot.data() != null) {
        final data = snapshot.data()![userId] as List<dynamic>;
        for (var postData in data) {
          JadwalEntity entity = JadwalEntity.fromDocument(postData);
          fetchedPosts.add(Jadwal.fromEntity(entity));
        }
      }
      selectedJadwal.value = fetchedPosts
          .where(
            (jadwal) =>
                jadwal.tanggalDanWaktu.year == select.year &&
                jadwal.tanggalDanWaktu.month == select.month &&
                jadwal.tanggalDanWaktu.day == select.day,
          )
          .toList();
    } catch (e) {
      log("Error fetching schedules: $e");
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
        await _firestore.collection('jadwal').doc(jadwal.myUser.id).update({
          jadwal.myUser.id:
              FieldValue.arrayRemove([jadwal.toEntity().toDocument()])
        });
      }
      selectedJadwal
          .removeWhere((jadwal) => selectedForDeletion.contains(jadwal));
      selectedForDeletion.clear();
      wantDelete.value = false;

      log("Selected schedules deleted successfully.");
    } catch (e) {
      log("Error deleting selected schedules: $e");
    }
  }

  String formatRupiah(num number, String symbol) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(number);
  }
}
