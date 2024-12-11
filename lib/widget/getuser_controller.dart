import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/myUser/myuser_entity.dart';
import '../models/myUser/myuser_model.dart';

class GetUserController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get userStream => auth.authStateChanges();
  var user = Rxn<MyUser>();

  Future<MyUserEntity?> getUser(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        return MyUserEntity.fromDocument(data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> fetchUser(String userId) async {
    MyUserEntity? userEntity = await getUser(userId);
    if (userEntity != null) {
      user.value = MyUser.fromEntity(userEntity);
    } else {
      log("No MyUserEntity found for ID: $userId");
    }
  }
}