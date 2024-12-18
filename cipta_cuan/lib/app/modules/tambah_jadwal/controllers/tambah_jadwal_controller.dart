import 'package:cipta_cuan/models/jadwal/jadwal_model.dart';
import 'package:cipta_cuan/widget/notification_servies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TambahJadwalController extends GetxController {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  final formKeyTambahJadwal = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DateTime? get selectedDateTime {
    if (selectedDate != null && selectedTime != null) {
      return DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    }
    return null;
  }

  void addData(Jadwal jadwal) async {
    try {
      jadwal.jadwalId = const Uuid().v1();
      jadwal.tanggalDitambahkan = DateTime.now();

      await firestore.collection('jadwal').doc(jadwal.myUser.id).set({
        jadwal.myUser.id:
            FieldValue.arrayUnion([jadwal.toEntity().toDocument()])
      }, SetOptions(merge: true));
      final notificationService = NotificationService();
      await notificationService.scheduleNotification(
        id: jadwal.jadwalId.hashCode,
        title: judulController.text,
        body: deskripsiController.text,
        scheduledDate: selectedDateTime!,
      );

      Navigator.pop(Get.context!);
      Get.snackbar('Success', 'Data added successfully');
      tanggalController.clear();
      jumlahController.clear();
      judulController.clear();
      deskripsiController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
      if (e is FirebaseException) {
        Get.snackbar('Error', 'Error code: ${e.code}, message: ${e.message}');
      }
      rethrow;
    }
  }

  @override
  void onClose() {
    tanggalController.dispose();
    jumlahController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
