import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/myUser/myuser_entity.dart';
import '../../../../models/myUser/myuser_model.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<User?> get userStream => auth.authStateChanges();

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasCompletedOnboarding = prefs.getBool('completedOnboarding');
    Future.delayed(
      Duration(seconds: 30));

    if (hasCompletedOnboarding == true) {
      userStream.listen((user) {
        if (user == null) {
          log("onBoarding");
        } else {
          log("home");
        }
      });
    } else {
      log("onBoarding");
    }
  }

  Future<MyUserEntity?> getUser(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(id).get();
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        return MyUserEntity.fromDocument(data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  var user = Rxn<MyUser>();

  Future<void> fetchUser(String userId) async {
    MyUserEntity? userEntity = await getUser(userId);
    if (userEntity != null) {
      user.value = MyUser.fromEntity(userEntity);
    } else {
      log("No MyUserEntity found for ID: $userId");
    }
  }
}
