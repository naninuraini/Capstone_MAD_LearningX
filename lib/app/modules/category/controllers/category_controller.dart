import 'package:get/get.dart';
import '../../../../models/post/post_model.dart';
import '../../../../models/post/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryController extends GetxController {
  // Daftar kategori
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

  void getPosts() async {
    try {
      final querySnapshot = await firestore.collection('transaksi').get();
      final posts = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Post.fromEntity(PostEntity.fromDocument(data, 'userId'));
      }).toList();

      allPosts.value = posts;
      print('All posts loaded: ${allPosts.length}');
    } catch (e) {
      print('Error fetching posts: $e');
      Get.snackbar('Error', 'Failed to load posts.');
    }
  }

  void filterPostsByCategory(String categoryLabel) {
    filteredPosts.value = allPosts.where((post) => post.kategori == categoryLabel).toList();
    print('Filtered posts: ${filteredPosts.map((post) => post.judul).toList()}');
    Get.toNamed('/category-list', arguments: {'category': categoryLabel});
  }

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }
}
