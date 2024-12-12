import 'dart:developer';

import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/button.dart';
import 'package:cipta_cuan/widget/popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/getuser_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaView extends StatefulWidget {
  const DetailPenggunaView({super.key});

  @override
  State<DetailPenggunaView> createState() => _DetailPenggunaViewState();
}

class _DetailPenggunaViewState extends State<DetailPenggunaView> {
  final DetailPenggunaController controller =
      Get.find<DetailPenggunaController>();
  final GetUserController getUserController = Get.find<GetUserController>();
  final myUser = Get.arguments as MyUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(Get.context!, true),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Detail Pengguna",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getUserController.userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            getUserController.fetchUser(user.uid);
            return Obx(
              () {
                final myUser = getUserController.user.value;
                if (myUser != null) {
                  return Column(
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/Avatar${myUser.avatar}.png'),
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1A1840),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF7B78AA),
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.PROFIL_AVATAR, arguments: myUser)
                                        ?.then((result) {
                                      if (result == true) {
                                        getUserController.fetchUser(user.uid);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        myUser.name.isNotEmpty
                            ? myUser.name
                            : "Nama tidak ditemukan",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF24325F),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50),
                            ),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 30),
                            children: [
                              _buildDetailItem("Nama Pengguna", myUser.name),
                              const SizedBox(height: 20),
                              _buildDetailItem("Email", myUser.email),
                              const SizedBox(height: 20),
                              _buildDetailItem("Saldo",
                                  controller.formatRupiah(myUser.saldo, 'Rp')),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: ButtonWidget(
                                  onPressed: () => _deleteAccount(context),
                                  title: "Hapus Akun",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  log("Waiting for user data...");
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('Tidak ada data pengguna.'),
            );
          }
        },
      ),
    );
  }

  // Future<Map<String, String>> _fetchUserData() async {
  //   try {
  //     final uid = FirebaseAuth.instance.currentUser?.uid;
  //     if (uid == null) {
  //       throw Exception("Pengguna tidak ditemukan");
  //     }

  //     final doc =
  //         await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //     if (!doc.exists) {
  //       throw Exception("Data pengguna tidak ditemukan");
  //     }

  //     final data = doc.data() as Map<String, dynamic>;
  //     return {
  //       'name': data['name'] ?? "Nama tidak ditemukan",
  //       'email': data['email'] ?? "Email tidak ditemukan",
  //       'saldo': data['saldo'] != null
  //           ? controller.formatRupiah(data['saldo'], 'Rp')
  //           : "Saldo tidak ditemukan",
  //     };
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<void> _deleteAccount(BuildContext context) async {
    ConfirmationPopup.show(
      context,
      title: "Apakah Anda yakin ingin menghapus akun ini?",
      imagePath: 'assets/images/delete_account.png',
      onConfirm: () async {
        try {
          final auth = FirebaseAuth.instance;
          final user = auth.currentUser;

          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .delete();

            await user.delete();

            Get.snackbar(
              "Berhasil",
              "Akun telah berhasil dihapus.",
              snackPosition: SnackPosition.BOTTOM,
            );

            await auth.signOut();

            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.snackbar(
              "Error",
              "Tidak ada pengguna yang sedang login.",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } catch (e) {
          if (e.toString().contains('requires-recent-login')) {
            Get.snackbar(
              "Error",
              "Anda harus login ulang untuk menghapus akun.",
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Get.snackbar(
              "Error",
              "Gagal menghapus akun: $e",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      },
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7B78AA),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7B78AA),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
