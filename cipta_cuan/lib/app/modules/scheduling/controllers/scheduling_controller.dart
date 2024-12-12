import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/jadwal/jadwal_entity.dart';
import '../../../../models/jadwal/jadwal_model.dart';

class SchedulingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var jadwalList = <Map<String, dynamic>>[].obs;

  void fetchJadwalByDate(DateTime date) async {
    try {
      String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      QuerySnapshot snapshot = await _firestore
          .collection('jadwal')
          .where('date', isEqualTo: formattedDate)
          .get();

      jadwalList.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching schedules: $e");
    }
  }

// class SchedulingController extends GetxController {
//   final selectedDateNow = DateTime.now().obs;
//   final jadwalList = <Jadwal>[].obs;
//   DateTime? selectedDate;
//   DateTime currentMonth = DateTime.now();
//   final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);

//     final daysInMonth =
//         DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
//     final firstDayWeekday = firstDayOfMonth.weekday;
//     final emptyDays = firstDayWeekday % 7;
//     final List<int?> dates = List.generate(
//       emptyDays,
//       (_) => null,
//     )..addAll(
//         List.generate(daysInMonth, (index) => index + 1),
//       );

//   @override
//   void onInit() {
//     super.onInit();
//     fetchJadwal();
//   }

//   Future<void> fetchJadwal() async {
//     try {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('jadwal')
//         .doc('YQ89bsvnc9eyu5uvf3ITr3CfO7L2')
//         .get();

//     // final jadwal = snapshot.docs.map((doc) => Jadwal.fromEntity(
//     //       JadwalEntity.fromDocument(doc.data()),
//     //     )).toList();
//     // jadwalList.addAll(jadwal);
//     if (snapshot.exists) {
//       final jadwalData = snapshot.data();

//       final jadwal = Jadwal.fromEntity(
//         JadwalEntity.fromDocument(jadwalData as Map<String, dynamic>),
//       );
//       jadwalList.add(jadwal);
//     } else {
//       log("Dokumen tidak ditemukan");
//     }
//     } catch (e) {
//       log("Error fetching jadwal: $e");
//     }

//     // return snapshot.docs.map((doc) => Jadwal.fromEntity(
//     //       JadwalEntity.fromDocument(doc.data()),
//     //     )).toList();
//   }

  // List<int?> getDatesInMonth() {
  //   final firstDayOfMonth = DateTime(selectedDate.value.year, selectedDate.value.month, 1);
  //   final daysInMonth = DateTime(selectedDate.value.year, selectedDate.value.month + 1, 0).day;
  //   final firstDayWeekday = firstDayOfMonth.weekday;

  //   return List.generate(
  //     firstDayWeekday == 7 ? 0 : firstDayWeekday,
  //     (_) => null,
  //   )..addAll(
  //       List.generate(daysInMonth, (index) => index + 1),
  //     );
  // }

  // void changeMonth(String newMonth) {
  //   final monthIndex = DateFormat('MMMM').parse(newMonth).month;
  //   selectedDate.value = DateTime(selectedDate.value.year, monthIndex, selectedDate.value.day);
  // }

  // void changeYear(int newYear) {
  //   selectedDate.value = DateTime(newYear, selectedDate.value.month, selectedDate.value.day);
  // }

  // Future<void> fetchJadwalForSelectedDate() async {
  //   final dateStart = DateTime(
  //     selectedDate.value.year,
  //     selectedDate.value.month,
  //     selectedDate.value.day,
  //   );
  //   final dateEnd = dateStart.add(const Duration(days: 1));

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('jadwal')
  //       .where('tanggalDanWaktu', isGreaterThanOrEqualTo: dateStart)
  //       .where('tanggalDanWaktu', isLessThan: dateEnd)
  //       .get();

  //   final jadwalData = querySnapshot.docs.map((doc) {
  //     return Jadwal.fromEntity(JadwalEntity.fromDocument(doc.data()));
  //   }).toList();

  //   jadwalList.assignAll(jadwalData);
  // }

  // void selectDate(int date) {
  //   selectedDate.value = DateTime(selectedDate.value.year, selectedDate.value.month, date);
  //   fetchJadwalForSelectedDate();
  // }

  String formatRupiah(num number, String symbol) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(number);
  }
}
