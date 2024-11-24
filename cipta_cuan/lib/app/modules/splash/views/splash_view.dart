import 'dart:developer';

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
            log("$snapshot");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingView();
            } else if (snapshot.hasData && snapshot.data!.emailVerified == true) {
              Future.microtask(() => Get.offAllNamed('/home'));
            } else {
              Future.microtask(() => Get.offAllNamed(Routes.ON_BOARDING));
            }
            return Text(
              'CiptaCuan',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            );
          }
        ),
      ),
    );
  }
}
