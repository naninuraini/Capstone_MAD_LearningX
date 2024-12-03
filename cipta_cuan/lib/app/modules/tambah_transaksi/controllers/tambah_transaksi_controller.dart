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

  void addData(Post post, String file) async {
    try {
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

      Get.back();
      Get.snackbar('Success', 'Data added successfully');
      tanggalController.clear();
      kategoriController.clear();
      jumlahController.clear();
      judulController.clear();
      deskripsiController.clear();
      gambarController.clear();
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
    kategoriController.dispose();
    jumlahController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    gambarController.dispose();
    super.onClose();
  }
}
