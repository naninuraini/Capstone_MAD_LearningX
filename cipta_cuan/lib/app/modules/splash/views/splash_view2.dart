import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_view3.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

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
                Image.asset('assets/splash2.png'),
                const SizedBox(height: 20),
                const Text(
                  'Kelola Keuangan Anda\nPantau saldo, histori transaksi, dan kontrol pengeluaran dalam satu aplikasi.',
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
                Get.off(() => const SplashScreen3());
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
              "2/3",
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
