import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingController controller = Get.find<OnBoardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          setState(() => controller.currentPage = index);
        },
        children: controller.buildPages(),
      ),
      bottomSheet: controller.currentPage == controller.buildPages().length - 1
          ? TextButton(
              onPressed: controller.completeOnboarding,
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 18),
              ),
            )
          : TextButton(
              onPressed: () {
                controller.pageController.nextPage(
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
              child: Text(
                "Next",
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
