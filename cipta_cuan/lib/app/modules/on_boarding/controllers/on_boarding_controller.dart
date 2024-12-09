import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  int currentPage = 0;
  
  List<Widget> buildPages() {
    return [
      _buildPage('Welcome to the App', 'Description of the first feature'),
      _buildPage('Stay Connected', 'Description of the second feature'),
      _buildPage('Get Started', 'Description of the third feature'),
    ];
  }

  Widget _buildPage(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white)),
          SizedBox(height: 20),
          Text(description, style: TextStyle(fontSize: 18,color: AppColors.white)),
        ],
      ),
    );
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedOnboarding', true);
    Get.offAllNamed('/login');
  }
}
