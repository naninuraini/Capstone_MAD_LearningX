import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TabController tabController;
  final selectedColor = Color(0xff1a73e8);
  // final unselectedColor = Color(0xff5f6368);
  final tabs = [
    Tab(text: 'Harian'),
    Tab(text: 'Mingguan'),
    Tab(text: 'Tahunan'),
  ];

  void logout() async {
    await auth.signOut();
    Get.offAll(() => const LoginView());
  }
}
