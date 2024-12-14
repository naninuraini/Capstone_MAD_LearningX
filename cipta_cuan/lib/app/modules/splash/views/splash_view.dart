import 'dart:developer';

import 'package:cipta_cuan/app/modules/home/bindings/home_binding.dart';
import 'package:cipta_cuan/app/modules/home/views/home_view.dart';
import 'package:cipta_cuan/widget/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.checkOnboardingStatus();
    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: controller.userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingView();
            } else if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data;
              if (user!.emailVerified) {
                controller.fetchUser(user.uid);
                return Obx(() {
                  final myUser = controller.user.value;
                  if (myUser != null) {
                    Future.microtask(() => Get.offAll(
                          () => HomeView(myUser: myUser),
                          binding: HomeBinding(),
                        ));
                  } else {
                    log("Waiting for user data...");
                  }
                  return CircularProgressIndicator();
                });
              }
            }
            if (snapshot.hasError) {
              return Text('Terjadi kesalahan: ${snapshot.error}');
            } else {
              Future.microtask(() => Get.offAllNamed(Routes.ON_BOARDING));
            }
            return ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color(0xFF0DA6C2),
                  Color(0xFF0E39C6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'CiptaCuan',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color:
                      Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
