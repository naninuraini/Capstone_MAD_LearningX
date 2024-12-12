import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  Rx<IconData> iconPassword = CupertinoIcons.eye_fill.obs;

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    iconPassword.value = obscurePassword.value
        ? CupertinoIcons.eye_fill
        : CupertinoIcons.eye_slash_fill;
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
        Get.snackbar('Success', 'User logged in successfully');
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', 'Please verify your email');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('wrong email');
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('wrong password');
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        log('too-many-requests');
        Get.snackbar('Error', 'Too many requests. Try again later.');
      }
      log(e.code);
    } catch (e) {
      log("$e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
