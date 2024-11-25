import 'package:cipta_cuan/app/modules/detail_pengguna/views/detail_pengguna_view.dart';
import 'package:cipta_cuan/app/modules/lupa_password/views/lupa_password_view.dart';
import 'package:cipta_cuan/app/modules/tentang_kami/views/tentang_kami_view.dart';
import 'package:cipta_cuan/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Profil",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF6C63FF)),
                ),
                SizedBox(height: 10),
                Text(
                  "@yourUsername",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF24325F),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  _buildMenuItem(
                    iconPath: 'assets/icons/icon_detailPengguna.svg',
                    title: "Detail Pengguna",
                    onTap: () {
                      Get.to(() => DetailPenggunaView());
                    },
                  ),
                  _buildMenuItem(
                    iconPath: 'assets/icons/icon_ubahPassword.svg',
                    title: "Ganti Kata Sandi",
                    onTap: () {
                      Get.toNamed(Routes.LUPA_PASSWORD);
                    },
                  ),
                  _buildMenuItem(
                    iconPath: 'assets/icons/icon_tentangKami.svg',
                    title: "Tentang Kami",
                    onTap: () {
                      Get.to(() => TentangKamiView());
                    },
                  ),
                  _buildMenuItem(
                    iconPath: 'assets/icons/icon_keluar.svg',
                    title: "Keluar",
                    onTap: controller.logoutBottomSheet,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF24325F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 53,
              width: 57,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
