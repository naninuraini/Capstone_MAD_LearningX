import 'package:cipta_cuan/app/modules/detail_transaksi/controllers/detail_transaksi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  const DetailTransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
        backgroundColor: Color(0xFF0E39C6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Transaksi
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0DA6C2), Color(0xFF0E39C6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color(0xFF375DFB), width: 1.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                controller.post.gambar, // Menampilkan gambar dari URL atau file lokal
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Judul Transaksi
            Text(
              controller.post.judul,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Deskripsi
            Text(
              controller.post.deskripsi,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            // Jumlah dan Kategori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.formattedAmount,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: controller.post.kategori == 'pemasukan' ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  controller.formattedDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
