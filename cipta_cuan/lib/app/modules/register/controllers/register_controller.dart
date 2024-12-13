import 'dart:developer';

import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widget/button.dart';
import '../../../../widget/constant.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  RxBool obscurePassword = true.obs;
  Rx<IconData> iconPassword = CupertinoIcons.eye_fill.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    iconPassword.value = obscurePassword.value
        ? CupertinoIcons.eye_fill
        : CupertinoIcons.eye_slash_fill;
  }

  void register(MyUser myUser, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);
      Get.snackbar('Success', 'User created successfully');
      userCredential.user!.sendEmailVerification();
      try {
        MyUser user = myUser.copyWith(id: userCredential.user?.uid);
        log("User: $user");
        usersCollection.doc(user.id).set(user.toEntity().toDocument());
      } catch (e) {
        log(e.toString());
        rethrow;
      }
      Get.defaultDialog(
        backgroundColor: Color(0xFFE1E1E1),
        title: 'Verifikasi Email',
        titlePadding: const EdgeInsets.only(top: 20),
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.greyPopUp,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        content: Column(
          children: [
            Image.asset("assets/images/verification_email.png"),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Silahkan verifikasi email Anda untuk melanjutkan. Kami telah mengirimkan tautan verifikasi.',
                style: TextStyle(
                  color: AppColors.greyPopUp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      userCredential.user!.sendEmailVerification();
                      Get.snackbar('Success', 'Email verification link sent');
                    },
                    title: "Batal",
                    colorTitle: AppColors.borderGrey,
                    width: double.infinity,
                    height: 46,
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: ButtonWidget(
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    title: "Konfirmasi",
                    width: double.infinity,
                    height: 46,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
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
