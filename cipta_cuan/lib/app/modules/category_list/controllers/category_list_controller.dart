import 'package:get/get.dart';
import '../../../../models/post/post_model.dart';
import '../../../../models/post/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryListController extends GetxController {
  final RxList<Post> categoryPosts = <Post>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getCategoryPosts(String categoryLabel) async {
    try {
      final querySnapshot = await firestore
          .collection('transaksi')
          .where('kategori', isEqualTo: categoryLabel)
          .get();

      final posts = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Post.fromEntity(PostEntity.fromDocument(data, 'userId'));
      }).toList();

      categoryPosts.value = posts;
      print('Posts for category "$categoryLabel" loaded: ${categoryPosts.length}');
    } catch (e) {
      print('Error fetching posts for category "$categoryLabel": $e');
      Get.snackbar('Error', 'Failed to load category posts.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    categoryPosts.clear();
  }
}
