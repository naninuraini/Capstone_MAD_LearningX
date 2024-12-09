import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilAvatarController extends GetxController {
  int selectedIndex = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid ?? " ";

  void selectAvatar(int index) {
    selectedIndex = index;
    update();
  }

  Future<void> saveAvatar() async {
    try {
      // final String selectedAvatarPath = 'assets/images/Avatar${selectedIndex + 1}.png';

      // final file = await _copyAssetToFile(selectedAvatarPath);

      // final ref = _storage.ref().child('avatars/${userId}_avatar.png');
      // await ref.putFile(file);

      // final avatarUrl = await ref.getDownloadURL();
      await _firestore.collection('users').doc(userId).update({
        'avatar': selectedIndex + 1,
      });

      Navigator.pop(Get.context!);
      Get.snackbar(
        "Sukses",
        "Avatar berhasil dipilih dan disimpan!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menyimpan avatar: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Future<File> _copyAssetToFile(String assetPath) async {
  //   final file = await DefaultCacheManager().getSingleFile(assetPath);
  //   return file;
  // }
}
