import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<MyUser> user = MyUser.empty.obs;
  Stream<User?> get userStream => auth.authStateChanges();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // _fetchUserData();
  }

  // Future<void> _fetchUserData() async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid ?? " ";
  //     if (userId.isEmpty) {
  //       Get.snackbar("Error", "ID pengguna tidak ditemukan");
  //       return;
  //     }
  //     final doc = await _firestore.collection('users').doc(userId).get();
  //     if (doc.exists) {
  //       user.value = MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()!));
  //     } else {
  //       Get.snackbar("Error", "Data pengguna tidak ditemukan");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Gagal mengambil data pengguna: $e");
  //   }
  // }

  void logoutBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF1B2656),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xFF5266C0),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            Image.asset("assets/images/logout.png", height: 191, width: 350),
            const SizedBox(height: 20),
            const Text(
              'Kamu Yakin Mau Meninggalkan Kami?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'Jika kamu keluar maka kita sudah tidak terkoneksi. Apakah kamu yakin sekali mau keluar?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () => Get.back(),
                    title: 'BATALKAN',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ButtonWidget(
                    onPressed: _logout,
                    title: 'KELUAR',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isDismissible: false,
      isScrollControlled: true,
    );
  }

  Future<void> _logout() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? " ";
      await _firestore.collection('users').doc(userId).update({
        'avatar': 'assets/images/Avatar1.png',
      });

      user.value = MyUser.empty;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "Gagal logout: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
