import 'dart:developer';

import 'package:cipta_cuan/models/post/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTransaksiController extends GetxController {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  final formKeyEditTransaksi = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? selectedDateTime;
  RxSet<Post> selectedForDeletion = <Post>{}.obs;

  void initialize(Post post) {
    tanggalController.text =
        DateFormat("d MMMM yyyy", "id_ID").format(post.tanggal);
    judulController.text = post.judul;
    deskripsiController.text = post.deskripsi;
    selectedDateTime = post.tanggal;
    selectedForDeletion.add(post);
  }

  void updatePost(Post post, String file) async {
    try {
      post.tanggal = selectedDateTime ?? post.tanggal;
      post.judul = judulController.text;
      post.deskripsi = deskripsiController.text;
      selectedForDeletion.add(post);

      for (var posts in selectedForDeletion) {
        var data = firestore.collection('transaksi').doc(posts.myUser.id);
        await data.update({
          posts.myUser.id:
              FieldValue.arrayUnion([posts.toEntity().toDocument()])
        });
      }
      Get.snackbar('Success', 'Transaksi updated successfully');
      Navigator.pop(Get.context!);
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
      await firestore.collection('transaksi').doc(post.myUser.id).set({
        post.myUser.id: FieldValue.arrayRemove([post.toEntity().toDocument()])
      }, SetOptions(merge: true));
      if (post.gambar.isNotEmpty) {
        Reference firebaseStorageRef =
            FirebaseStorage.instance.refFromURL(post.gambar);
        await firebaseStorageRef.delete();
      }

      final docRef = firestore.collection('users').doc(post.myUser.id);
      firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (snapshot.exists) {
          final saldoValue = snapshot.get('saldo') as int? ?? 0;
          final pengeluaranValue = snapshot.get('pengeluaran') as int? ?? 0;
          if (post.kategori == 'Tabungan') {
            final newSaldoValue = saldoValue - post.jumlah;
            transaction.update(docRef, {'saldo': newSaldoValue});
          } else {
            final newSaldoValue = saldoValue - post.jumlah;
            transaction.update(docRef, {'saldo': newSaldoValue});
            final newPengeluaranValue = pengeluaranValue - post.jumlah;
            transaction.update(docRef, {'pengeluaran': newPengeluaranValue});
          }
        }
      }).catchError((error) {
        print("Error updating Firestore value: $error");
      });
    } catch (e) {
      log("delete post error: $e");
      if (e is FirebaseException) {
        log("Error code: ${e.code}, message: ${e.message}");
      }
      rethrow;
    }
  }

  @override
  void onClose() {
    tanggalController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
