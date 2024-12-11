import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends StatelessWidget {
  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => controller.currentPage.value = index,
        children: controller.buildPages(),
      ),
      // bottomNavigationBar: 
      // controller.currentPage.value < 2
      //     ? Obx(() {
      //         final isLastPage = controller.currentPage.value ==
      //             controller.buildPages().length - 1;

              // return Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       controller.pageController.nextPage(
              //         duration: const Duration(milliseconds: 300),
              //         curve: Curves.ease,
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFF0DA6C2),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     child: Text(
              //       'Next',
              //       style: const TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //   ),
              // );
    //         })
    //       : Container(),
    );
  }
}
