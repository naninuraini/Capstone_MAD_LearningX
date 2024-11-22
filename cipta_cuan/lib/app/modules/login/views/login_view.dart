import 'package:cipta_cuan/widget/button.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:cipta_cuan/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../widget/validators.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKeyLogin,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset("assets/images/logo.png"),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Masuk Ke Akun Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.borderCard,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppColors.backgroundCard,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25.0,
                    ),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          prefixIcon: "assets/icons/email.svg",
                          hintText: 'email',
                          obscurePassword: false,
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[\w\-.@]+$'),
                            ),
                          ],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Email Tidak Boleh Kosong';
                            } else if (!emailRexExp.hasMatch(val)) {
                              return 'Email Tidak Valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFieldWidget(
                          prefixIcon: "assets/icons/kata_sandi.svg",
                          hintText: 'kata sandi',
                          obscurePassword: controller.obscurePassword,
                          controller: controller.passwordController,
                          suffixIcon: controller.iconPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Password Tidak Boleh Kosong';
                            } else if (!passRexExp.hasMatch(val)) {
                              return 'Password Tidak Valid';
                            } else {
                              return null;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LUPA_PASSWORD);
                  },
                  child: const Text(
                    'Lupa Kata Sandi',
                    style: TextStyle(color: AppColors.textPurple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: ButtonWidget(
                    onPressed: () {
                      if (controller.formKeyLogin.currentState!.validate()) {
                        controller.login(controller.emailController.text,
                            controller.passwordController.text);
                      }
                    },
                    title: "Masuk",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum Punya Akun?',
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextButton(
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: AppColors.textPurple),
                      ),
                      onPressed: () {
                        Get.offNamed(Routes.REGISTER);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
