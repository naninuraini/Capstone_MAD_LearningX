import 'package:cipta_cuan/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  void logoutBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          top: 55,
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
            const SizedBox(height: 50),
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
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    title: 'KELUAR',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isDismissible: false,
    );
  }
}
