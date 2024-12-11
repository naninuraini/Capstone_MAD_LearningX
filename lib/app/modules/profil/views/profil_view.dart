import 'package:cipta_cuan/app/modules/profil/controllers/profil_controller.dart';
import 'package:cipta_cuan/app/routes/app_pages.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfilView extends GetView<ProfilController> {
  final MyUser? myUser;
  const ProfilView(this.myUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage:
                AssetImage('assets/images/Avatar${myUser!.avatar}.png'),
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            myUser!.name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
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
                      Get.toNamed(Routes.DETAIL_PENGGUNA, arguments: myUser);
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
                      Get.toNamed(Routes.TENTANG_KAMI);
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
          )
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
