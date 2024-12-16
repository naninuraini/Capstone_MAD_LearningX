import 'dart:developer';
import 'dart:io';

import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TambahTransaksiController extends GetxController {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  final formKeyTambahTransaksi = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? selectedDateTime;
  var dropdownItems = [
    'Konsumsi',
    'Transportasi',
    'Obat-Obatan',
    'Bahan Makanan',
    'Sewa',
    'Hadiah',
    'Tabungan',
    'Hiburan',
    'Lainnya'
  ].obs;
  var selectedItem = ''.obs;
  var isDropdownVisible = false.obs;

  void addData(Post post, String file, BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: const Color(0xFFE1E1E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ));
        },
      );
      post.postId = const Uuid().v1();
      post.tanggalDitambahkan = DateTime.now();
      String potoId = const Uuid().v1();
      String bulan = DateFormat(DateFormat.MONTH).format(DateTime.now());

      File imageFile = File(file);
      Reference firebaseStoreRef = FirebaseStorage.instance
          .ref()
          .child('transaksi/${post.myUser.id}/$bulan/$potoId');
      await firebaseStoreRef.putFile(imageFile);
      String url = await firebaseStoreRef.getDownloadURL();
      post.gambar = url;

      await firestore.collection('transaksi').doc(post.myUser.id).set({
        post.myUser.id: FieldValue.arrayUnion([post.toEntity().toDocument()])
      }, SetOptions(merge: true));

      updateSaldo(post.myUser.id, post.jumlah, post);
      tanggalController.clear();
      kategoriController.clear();
      jumlahController.clear();
      judulController.clear();
      deskripsiController.clear();
      gambarController.clear();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Get.snackbar('Success', 'Data added successfully');
    } catch (e) {
      log("post error: $e");
      if (e is FirebaseException) {
        log("Error code: ${e.code}, message: ${e.message}");
      }
      rethrow;
    }
  }

  void updateSaldo(String documentId, int incrementValue, Post post) async {
    try {
      final docRef = firestore.collection('users').doc(documentId);
      firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (snapshot.exists) {
          final saldoValue = snapshot.get('saldo') as int? ?? 0;
          final pengeluaranValue = snapshot.get('pengeluaran') as int? ?? 0;
          if (post.kategori == 'Tabungan') {
            final newSaldoValue = saldoValue + incrementValue;
            transaction.update(docRef, {'saldo': newSaldoValue});
          } else {
            final newSaldoValue = saldoValue - incrementValue;
            transaction.update(docRef, {'saldo': newSaldoValue});
            final newPengeluaranValue = pengeluaranValue + incrementValue;
            transaction.update(docRef, {'pengeluaran': newPengeluaranValue});
          }
        } else {
          transaction.set(docRef, {'saldo': incrementValue});
        }
      }).catchError((error) {
        print("Error updating Firestore value: $error");
      });
    } catch (e) {
      log("$e");
    }
  }

  void toggleDropdown() {
    isDropdownVisible.value = !isDropdownVisible.value;
    print("Dropdown visibility: ${isDropdownVisible.value}");
  }

  void selectItem(String item) {
    selectedItem.value = item;
    isDropdownVisible.value = false;
  }

  @override
  void onClose() {
    tanggalController.dispose();
    kategoriController.dispose();
    jumlahController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    gambarController.dispose();
    super.onClose();
  }
}
