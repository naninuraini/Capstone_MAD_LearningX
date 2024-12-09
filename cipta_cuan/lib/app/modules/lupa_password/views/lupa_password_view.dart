import 'package:cipta_cuan/app/routes/app_pages.dart';  
import 'package:cipta_cuan/widget/button.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:cipta_cuan/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/validators.dart';
import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  LupaPasswordView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>(); // Local key

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded, 
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      " Lupa Kata Sandi",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Masukkan Email Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10).copyWith(left: 15), 
                  child: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85, 
                      child: TextFieldWidget(
                        prefixIcon: "assets/icons/email.svg",
                        hintText: 'Masukkan Email',
                        obscurePassword: false,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Email Tidak Boleh Kosong';
                          } else if (!emailRexExp.hasMatch(val)) {
                            return 'Email Tidak Valid';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.resetPassword(controller.emailController.text);
                        }
                      },
                      title: "Kirim",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun?',
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: AppColors.textPurple),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
