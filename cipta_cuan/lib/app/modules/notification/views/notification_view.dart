import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  final String userId;

  NotificationView({required this.userId});

  @override
  Widget build(BuildContext context) {
    // Validasi userId tidak kosong
    if (userId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Daftar Notifikasi')),
        body: Center(child: Text('User ID tidak valid')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Notifikasi')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jadwal')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Center(child: Text('Tidak ada notifikasi'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final jadwalList = data['jadwal'] as List<dynamic>? ?? [];

          if (jadwalList.isEmpty) {
            return Center(child: Text('Tidak ada notifikasi'));
          }

          return ListView.builder(
            itemCount: jadwalList.length,
            itemBuilder: (context, index) {
              final jadwal = jadwalList[index] as Map<String, dynamic>;
              final judul = jadwal['judul'] ?? 'Judul tidak tersedia';
              final deskripsi = jadwal['deskripsi'] ?? 'Deskripsi tidak tersedia';
              final tanggalDanWaktu = jadwal['tanggalDanWaktu'] != null
                  ? DateFormat('dd MMM yyyy, HH:mm').format(
                      (jadwal['tanggalDanWaktu'] as Timestamp).toDate(),
                    )
                  : 'Tanggal tidak tersedia';

              return ListTile(
                title: Text(judul),
                subtitle: Text(deskripsi),
                trailing: Text(tanggalDanWaktu),
              );
            },
          );
        },
      ),
    );
  }
}
