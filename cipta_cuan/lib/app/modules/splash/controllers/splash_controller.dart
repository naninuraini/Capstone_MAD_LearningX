import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get userStream => auth.authStateChanges();

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasCompletedOnboarding = prefs.getBool('completedOnboarding');

    if (hasCompletedOnboarding == true) {
      userStream.listen((user) {
        if (user == null) {
          Get.offAllNamed(Routes.ON_BOARDING);
        } else {
          Get.offAllNamed('/home');
        }
      });
    } else {
      Get.offAllNamed(Routes.ON_BOARDING);
    }
  }
}
