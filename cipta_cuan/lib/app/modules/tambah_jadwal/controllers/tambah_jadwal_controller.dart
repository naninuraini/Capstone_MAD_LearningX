import 'dart:developer';
import 'package:cipta_cuan/app/modules/notifikasi/controllers/notifikasi_controller.dart';
import 'package:cipta_cuan/models/jadwal/jadwal_model.dart';
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
  final isLoading = false.obs;

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

  final NotificationController notificationController = Get.find();

  void addData(Jadwal jadwal) async {
    try {
      isLoading.value = true;
      jadwal.jadwalId = const Uuid().v1();
      jadwal.tanggalDitambahkan = DateTime.now();

      // Pastikan dokumen path yang valid
      await firestore.collection('jadwal').doc(jadwal.myUser.id).set({
        jadwal.myUser.id: FieldValue.arrayUnion([jadwal.toEntity().toDocument()])
      }, SetOptions(merge: true));

      // Tambahkan notifikasi setelah menyimpan jadwal
      if (selectedDateTime != null) {
        notificationController.addScheduledNotification(
          jadwal.judul,
          jadwal.deskripsi,
          selectedDateTime!,
        );
      }

      Navigator.pop(Get.context!);
      Get.snackbar('Success', 'Data added successfully');
      tanggalController.clear();
      jumlahController.clear();
      judulController.clear();
      deskripsiController.clear();
    } catch (e) {
      log("post error: $e");
      if (e is FirebaseException) {
        log("Error code: ${e.code}, message: ${e.message}");
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


// import 'dart:developer';

// import 'package:cipta_cuan/models/jadwal/jadwal_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

// class TambahJadwalController extends GetxController {
//   TextEditingController tanggalController = TextEditingController();
//   TextEditingController waktuController = TextEditingController();
//   TextEditingController jumlahController = TextEditingController();
//   TextEditingController judulController = TextEditingController();
//   TextEditingController deskripsiController = TextEditingController();
//   final formKeyTambahJadwal = GlobalKey<FormState>();
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   // DateTime? selectedDateTime;
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;

//   DateTime? get selectedDateTime {
//     if (selectedDate != null && selectedTime != null) {
//       return DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         selectedTime!.hour,
//         selectedTime!.minute,
//       );
//     }
//     return null;
//   }

//   void addData(Jadwal jadwal) async {
//     try {
//       jadwal.jadwalId = const Uuid().v1();
//       jadwal.tanggalDitambahkan = DateTime.now();

//       await firestore.collection('jadwal').doc(jadwal.myUser.id).set({
//         jadwal.myUser.id: FieldValue.arrayUnion([jadwal.toEntity().toDocument()])
//       }, SetOptions(merge: true));

//       Navigator.pop(Get.context!);
//       Get.snackbar('Success', 'Data added successfully');
//       tanggalController.clear();
//       jumlahController.clear();
//       judulController.clear();
//       deskripsiController.clear();
//     } catch (e) {
//       log("post error: $e");
//       if (e is FirebaseException) {
//         log("Error code: ${e.code}, message: ${e.message}");
//       }
//       rethrow;
//     }
//   }

//   @override
//   void onClose() {
//     tanggalController.dispose();
//     jumlahController.dispose();
//     judulController.dispose();
//     deskripsiController.dispose();
//     super.onClose();
//   }
// }
