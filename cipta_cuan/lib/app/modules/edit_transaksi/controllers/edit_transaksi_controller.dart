import 'dart:developer';
import 'dart:io';

import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EditTransaksiController extends GetxController {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  final formKeyEditTransaksi = GlobalKey<FormState>();
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

  void initialize(Post post) {
    tanggalController.text = DateFormat("d MMMM yyyy", "id_ID").format(post.tanggal);
    kategoriController.text = post.kategori;
    jumlahController.text = post.jumlah.toString();
    judulController.text = post.judul;
    deskripsiController.text = post.deskripsi;
  }

  void updatePost(Post post, String file) async {
    try {
      post.tanggal = selectedDateTime ?? DateTime.now();
      post.kategori = kategoriController.text;
      post.jumlah = int.parse(jumlahController.text);
      post.judul = judulController.text;
      post.deskripsi = deskripsiController.text;

      // image
      if (file.isNotEmpty) {
        File imageFile = File(file);
        String potoId = const Uuid().v1();
        String bulan = DateFormat(DateFormat.MONTH).format(DateTime.now());

        Reference firebaseStoreRef = FirebaseStorage.instance
            .ref()
            .child('transaksi/${post.myUser.id}/$bulan/$potoId');
        await firebaseStoreRef.putFile(imageFile);
        String url = await firebaseStoreRef.getDownloadURL();
        post.gambar = url;
      }

      // update firestore
      await firestore.collection('transaksi').doc(post.myUser.id).set({
        post.myUser.id: FieldValue.arrayRemove([post.toEntity().toDocument()])
      }, SetOptions(merge: true));

      await firestore.collection('transaksi').doc(post.myUser.id).set({
        post.myUser.id: FieldValue.arrayUnion([post.toEntity().toDocument()])
      }, SetOptions(merge: true));

      updateSaldo(post.myUser.id, post.jumlah, post);

      Get.snackbar('Success', 'Transaksi updated successfully');
      Navigator.pop(Get.context!);
    } catch (e) {
      log("update post error: $e");
      if (e is FirebaseException) {
        log("Error code: ${e.code}, message: ${e.message}");
      }
      rethrow;
    }
  }

  void deletePost(Post post) async {
    try {
      // hapus post firestrore
      await firestore.collection('transaksi').doc(post.myUser.id).set({
        post.myUser.id: FieldValue.arrayRemove([post.toEntity().toDocument()])
      }, SetOptions(merge: true));

      // hapus image
      if (post.gambar.isNotEmpty) {
        Reference firebaseStorageRef = FirebaseStorage.instance.refFromURL(post.gambar);
        await firebaseStorageRef.delete();
      }

      Get.snackbar('Success', 'Transaksi deleted successfully');
      Navigator.pop(Get.context!);
    } catch (e) {
      log("delete post error: $e");
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
