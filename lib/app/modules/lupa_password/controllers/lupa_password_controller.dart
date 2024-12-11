import 'dart:developer'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipta_cuan/app/routes/app_pages.dart';
import 'package:cipta_cuan/widget/button.dart';
import 'package:cipta_cuan/widget/constant.dart';

class LupaPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  final formKeyLupaPassword = GlobalKey<FormState>();

  void resetPassword(String email) async {
    try {
      auth.setLanguageCode('id');
      await auth.sendPasswordResetEmail(email: email);
      log('Password reset email sent to $email');

      Get.defaultDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        title: 'Reset Password',
        titlePadding: const EdgeInsets.only(top: 30.0),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        contentPadding: const EdgeInsets.all(25.0),
        content: Column(
          children: [
            Image.asset("assets/images/verification_email.png"),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Silahkan cek email Anda untuk melanjutkan. Kami telah mengirimkan tautan reset password.',
                style: TextStyle(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        confirm: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.5),
          child: ButtonWidget(
            height: 40,
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            title: "Konfirmasi",
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Gagal mengirim email reset password. Coba lagi nanti.';
      log('Error: $message');
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
      );
    } catch (e) {
      log('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan tidak terduga. Silakan coba lagi.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}