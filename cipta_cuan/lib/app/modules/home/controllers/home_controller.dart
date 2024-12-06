import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/post/post_entity.dart';
import '../../../../models/post/post_model.dart';
import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  late TabController tabController;
  final selectedColor = Color(0xff1a73e8);
  var dailyTransactions = <Post>[].obs;
  var weeklyTransactions = <Post>[].obs;
  var yearlyTransactions = <Post>[].obs;

  final tabs = [
    Tab(text: 'Harian'),
    Tab(text: 'Mingguan'),
    Tab(text: 'Tahunan'),
  ];

  Future<void> getPosts(String myUserId) async {
    try {
      isLoading.value = true;
      List<Post> fetchedPosts = [];
      var snapshot =
          await _firestore.collection('transaksi').doc(myUserId).get();

      if (snapshot.data() != null) {
        final data = snapshot.data()![myUserId] as List<dynamic>;
        for (var postData in data) {
          PostEntity entity = PostEntity.fromDocument(postData, myUserId);
          fetchedPosts.add(Post.fromEntity(entity));
        }
      }
      // posts.value = fetchedPosts;

      DateTime today = DateTime.now();
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      DateTime startOfYear = DateTime(today.year);

      dailyTransactions.value = fetchedPosts
          .where((post) =>
              post.tanggal.year == today.year &&
              post.tanggal.month == today.month &&
              post.tanggal.day == today.day)
          .toList();
      // log("harian: ${dailyTransactions}");

      weeklyTransactions.value = fetchedPosts
          .where((post) =>
              post.tanggal
                  .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
              post.tanggal.isBefore(today.add(const Duration(days: 1))))
          .toList();
      // log("mingguan: ${weeklyTransactions}");

      yearlyTransactions.value = fetchedPosts
          .where((post) => post.tanggal.year == today.year)
          .toList();
      // log("tahunan: ${yearlyTransactions}");

    } catch (e) {
      print("Error fetching posts: $e");
      Get.snackbar('Error', 'Failed to load posts');
    } finally {
      isLoading.value = false;
    }
  }

  String formatRupiah(num number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(number);
  }

  void logout() async {
    await auth.signOut();
    Get.offAll(() => const LoginView());
  }
}
