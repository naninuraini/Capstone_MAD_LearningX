import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  int currentPage = 0;

  List<Widget> buildPages() {
    return [
      _buildPage(
        imagePath: 'assets/onboarding/boarding.png',
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat datang',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'di',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF0DA6C2),
                      Color(0xFF0E39C6),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: const Text(
                    'CiptaCuan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  '!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        description:
            'Mulai atur keuangan Anda dengan cara yang lebih mudah dan aman.',
      ),
      _buildPage(
        imagePath: 'assets/onboarding/boarding.png',
        title: const Text(
          'Kelola Keuangan Anda',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        description:
            'Pantau saldo, histori transaksi, dan kontrol pengeluaran dalam satu aplikasi.',
      ),
      _buildPage(
        imagePath: 'assets/onboarding/boarding.png',
        title: const Text(
          'Menabung Lebih Praktis',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        description:
            'Nikmati kemudahan menabung dengan fitur pintar untuk mencapai tujuan finansial Anda.',
      ),
    ];
  }

  Widget _buildPage({
    required String imagePath,
    required Widget title,
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
              title,
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
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Color(0xFF0DA6C2),
                Color(0xFF0E39C6),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              '${currentPage + 1}/3',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
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
