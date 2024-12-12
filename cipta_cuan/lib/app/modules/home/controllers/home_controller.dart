import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/post/post_entity.dart';
import '../../../../models/post/post_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  late TabController tabController;
  final selectedColor = Color(0xff1a73e8);
  var dailyTransactions = <Post>[].obs;
  var weeklyTransactions = <Post>[].obs;
  var monthlyTransactions = <Post>[].obs;

  final tabs = [
    Tab(text: 'Harian'),
    Tab(text: 'Mingguan'),
    Tab(text: 'Bulanan'),
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
          PostEntity entity = PostEntity.fromDocument(postData);
          fetchedPosts.add(Post.fromEntity(entity));
        }
      }
      posts.value = fetchedPosts;

      DateTime today = DateTime.now();
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      // DateTime startOfMonth = DateTime(today.year, today.month);

      dailyTransactions.value = fetchedPosts
          .where((post) =>
              post.tanggal.year == today.year &&
              post.tanggal.month == today.month &&
              post.tanggal.day == today.day)
          .toList();

      weeklyTransactions.value = fetchedPosts
          .where((post) =>
              post.tanggal
                  .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
              post.tanggal.isBefore(today.add(const Duration(days: 1))))
          .toList();

      monthlyTransactions.value = fetchedPosts
          .where((post) =>
              post.tanggal.year == today.year &&
              post.tanggal.month == today.month)
          .toList();
    } catch (e) {
      print("Error fetching posts: $e");
      Get.snackbar('Error', 'Failed to load posts');
    } finally {
      isLoading.value = false;
    }
  }

  String formatRupiah(num number, String symbol) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(number);
  }

  final Map<String, String> categoryImages = {
    'Konsumsi': 'assets/category/konsumsi.png',
    'Transportasi': 'assets/category/transportasi.png',
    'Obat-Obatan': 'assets/category/obat.png',
    'Bahan Makanan': 'assets/category/makanan.png',
    'Sewa': 'assets/category/sewa.png',
    'Hadiah': 'assets/category/hadiah.png',
    'Tabungan': 'assets/category/tabungan.png',
    'Hiburan': 'assets/category/hiburan.png',
    'Lainnya': 'assets/category/lainnya.png',
  };

  double calculateExpensePercentage(int saldo, int pengeluaran) {
    if (saldo == 0) return 0;
    return (pengeluaran / saldo).clamp(0.0, 1.0);
  }
}
