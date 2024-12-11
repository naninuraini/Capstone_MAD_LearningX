import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipta_cuan/app/modules/detail_transaksi/controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  const DetailTransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // untuk kategorinya
    var category = controller.categories.firstWhere(
      (category) => category['label'] == controller.post.kategori,
      orElse: () => {"icon": "assets/category/lainnya.png", "label": "Lainnya"},
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.post.judul,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF19173D),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF19173D),
      body: Column(
        children: [
          // Bagian atas: Icon dan Kategori
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFF6DB6FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    category['icon']!,
                    width: 42,
                    height: 42,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                category['label']!,
                style: TextStyle(
                  color: category['label'] == 'Tabungan' ? Colors.green : Colors.red,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                controller.formattedAmount,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Bagian bawah: Detail Transaksi
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1B2656),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Detail Transaksi",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 10),
                    buildDetailRow("Deskripsi", controller.post.deskripsi),
                    buildDetailRow("Tanggal", controller.formattedDate),
                    buildDetailRow("Judul", controller.post.judul),
                    const Divider(color: Colors.black),
                    buildDetailRow("Jumlah", controller.formattedAmount),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Center(
                                        child: Image.network(
                                          controller.post.gambar,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  controller.post.gambar,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          // Action for Edit button
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0DA6C2),
                                Color(0xFF0E39C6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: const Color(0xFF375DFB),
                              width: 1.0,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}