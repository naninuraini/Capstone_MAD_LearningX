import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  // Memastikan controller diinisialisasi dengan benar
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigasi kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Obx(() {
        // Memeriksa apakah daftar notifikasi kosong
        if (controller.notifications.isEmpty) {
          return _buildEmptyNotification();
        } else {
          return _buildNotificationList();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.clearNotifications, // Membersihkan notifikasi
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.delete),
      ),
    );
  }

  // Widget untuk tampilan jika tidak ada notifikasi
  Widget _buildEmptyNotification() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pastikan gambar tersedia di path yang benar
          Image.asset(
            'assets/images/no_notifications.png', // Ganti sesuai lokasi gambar
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.notifications_off,
                size: 100,
                color: Colors.grey,
              ); // Ikon pengganti jika gambar tidak ditemukan
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Notifikasi Apapun',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Istirahat sejenak kawan, kamu belum mendapatkan notifikasi apapun',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan daftar notifikasi
  Widget _buildNotificationList() {
    return ListView.builder(
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final item = controller.notifications[index];

        // Pastikan data notifikasi tidak null sebelum diakses
        final title = item['title'] ?? 'Tidak ada judul';
        final message = item['message'] ?? 'Tidak ada pesan';
        final date = item['date'] ?? 'Tanggal tidak tersedia';

        return ListTile(
          leading: const Icon(
            Icons.notifications,
            color: Colors.blue,
          ),
          title: Text(title),
          subtitle: Text(message),
          trailing: Text(date),
        );
      },
    );
  }
}
