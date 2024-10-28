import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_view2.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // Warna biru navy
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/splash1.png'),
                const SizedBox(height: 20),
                const Text(
                  'Selamat datang di CiptaCuan\nMulai atur keuangan Anda dengan cara yang lebih mudah dan aman.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Get.off(() => const SplashScreen2());
              },
              child: const Text(
                'Lewati',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: const Text(
              "1/3",
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
