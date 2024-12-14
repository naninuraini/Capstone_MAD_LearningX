import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../models/post/post_model.dart';

class CategoryController extends GetxController {
  final List<Map<String, String>> categories = [
    {"icon": "assets/category/konsumsi.png", "label": "Konsumsi"},
    {"icon": "assets/category/transportasi.png", "label": "Transportasi"},
    {"icon": "assets/category/obat.png", "label": "Obat-Obatan"},
    {"icon": "assets/category/makanan.png", "label": "Bahan Makanan"},
    {"icon": "assets/category/sewa.png", "label": "Sewa"},
    {"icon": "assets/category/hadiah.png", "label": "Hadiah"},
    {"icon": "assets/category/tabungan.png", "label": "Tabungan"},
    {"icon": "assets/category/hiburan.png", "label": "Hiburan"},
    {"icon": "assets/category/lainnya.png", "label": "Lainnya"},
  ];

  final RxList<Post> allPosts = <Post>[].obs;
  final RxList<Post> filteredPosts = <Post>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void filterPostsByCategory(String categoryLabel, MyUser myUser) {
    filteredPosts.value =
        allPosts.where((post) => post.kategori == categoryLabel).toList();
    Get.toNamed('/category-list', arguments: {
      'category': categoryLabel,
      'myUser': myUser,
    });
  }
}
