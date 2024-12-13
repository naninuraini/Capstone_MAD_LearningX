import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  final String userId;

  NotificationView({required this.userId});

  @override
  Widget build(BuildContext context) {
    // Validasi userId tidak kosong
    // if (userId.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Daftar Notifikasi'),
    //       backgroundColor: Colors.blue[900],
    //     ),
    //     body: const Center(
    //       child: Text(
    //         'User ID tidak valid',
    //         style: TextStyle(fontSize: 16, color: Colors.black54),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jadwal')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return _buildEmptyNotification();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final jadwalList = data['jadwal'] as List<dynamic>? ?? [];

          if (jadwalList.isEmpty) {
            return _buildEmptyNotification();
          }

          return ListView.builder(
            itemCount: jadwalList.length,
            itemBuilder: (context, index) {
              final jadwal = jadwalList[index] as Map<String, dynamic>;
              final judul = jadwal['judul'] ?? 'Judul tidak tersedia';
              final deskripsi =
                  jadwal['deskripsi'] ?? 'Deskripsi tidak tersedia';
              final tanggalDanWaktu = jadwal['tanggalDanWaktu'] != null
                  ? DateFormat('dd MMM yyyy').format(
                      (jadwal['tanggalDanWaktu'] as Timestamp).toDate(),
                    )
                  : 'Tanggal tidak tersedia';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    judul,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(deskripsi),
                  trailing: Text(
                    tanggalDanWaktu,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.delete),
        onPressed: () => _showDeleteConfirmation(context),
      ),
    );
  }

  // Widget untuk menampilkan notifikasi kosong
  Widget _buildEmptyNotification() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_notifications.png',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.notifications_off,
                size: 100,
                color: Colors.grey,
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Notifikasi Apapun',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Istirahat sejenak kawan, kamu belum mendapatkan notifikasi apapun',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Popup konfirmasi penghapusan notifikasi
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus Notifikasi'),
          content:
              const Text('Apakah Anda yakin ingin menghapus semua notifikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menghapus notifikasi di Firebase
                FirebaseFirestore.instance
                    .collection('jadwal')
                    .doc(userId)
                    .update({'jadwal': []});
                Navigator.of(context).pop();
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
}
