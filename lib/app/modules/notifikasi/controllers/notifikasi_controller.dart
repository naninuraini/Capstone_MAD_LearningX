import 'package:get/get.dart';

class NotifikasiController extends GetxController {
  // Data notifikasi
  var notifications = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Memuat notifikasi awal
    loadNotifications();
  }

  void loadNotifications() {
    // notifications.addAll([
    //   {
    //     'title': 'Tagihan',
    //     'message': 'Ada tagihan yang harus kamu bayar sebelum jatuh tempo!',
    //     'date': '24 Oktober 2024',
    //   },
    //   {
    //     'title': 'Transaksi',
    //     'message': 'Transaksi baru berhasil ditambahkan.',
    //     'date': '23 Oktober 2024',
    //   },
    // ]);
    notifications([]);
  }

  void clearNotifications() {
    notifications.clear(); // Menghapus semua notifikasi
  }
}
