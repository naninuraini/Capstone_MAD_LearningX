import 'package:get/get.dart';
import '../../../../models/post/post_model.dart';
import '../../../../models/post/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryListController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var posts = <Post>[].obs;

  void getCategoryPosts(String myUserId, String categoryLabel) async {
    try {
      isLoading.value = true;
      List<Post> fetchedPosts = [];
      var snapshot =
          await firestore.collection('transaksi').doc(myUserId).get();

      if (snapshot.data() != null) {
        final data = snapshot.data()![myUserId] as List<dynamic>;
        for (var postData in data) {
          PostEntity entity = PostEntity.fromDocument(postData);
          fetchedPosts.add(Post.fromEntity(entity));
        }
      }

      posts.value =
          fetchedPosts.where((post) => post.kategori == categoryLabel).toList();

      print(
          'Posts for category "$categoryLabel" loaded: ${posts.length}');
    } catch (e) {
      print('Error fetching posts for category "$categoryLabel": $e');
      Get.snackbar('Error', 'Failed to load category posts.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    posts.clear();
  }
}
