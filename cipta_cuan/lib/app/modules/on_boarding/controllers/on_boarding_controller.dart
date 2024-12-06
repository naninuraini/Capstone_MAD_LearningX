import 'package:cipta_cuan/app/modules/splash/controllers/splash_controller.dart';
import 'package:cipta_cuan/widget/constant.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  int currentPage = 0;

  List<Widget> buildPages() {
    return [
      _buildPage(
        imagePath: 'assets/onboarding/splash1.png',
        title: 'Selamat datang di CiptaCuan',
        description: 'Mulai atur keuangan Anda dengan cara yang lebih mudah dan aman.',
      ),
      _buildPage(
        imagePath: 'assets/onboarding/splash2.png',
        title: 'Kelola Keuangan Anda',
        description: 'Pantau saldo, histori transaksi, dan kontrol pengeluaran dalam satu aplikasi.',
      ),
      _buildPage(
        imagePath: 'assets/onboarding/splash3.png',
        title: 'Menabung Lebih Praktis',
        description: 'Nikmati kemudahan menabung dengan fitur pintar untuk mencapai tujuan finansial Anda.',
      ),
    ];
  }

  Widget _buildPage({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 200),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 20,
          child: Text(
            '${currentPage + 1}/3',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedOnboarding', true);
    Get.offAllNamed('/login');
  }
}
