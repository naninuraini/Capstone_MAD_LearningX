import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/post/post_model.dart';
import '../../../../models/post/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryListController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var posts = <Post>[].obs;

  final categories = [
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
      isLoading.value = false;

      print(
          'Posts for category "$categoryLabel" loaded: ${posts.length}');
    } catch (e) {
      print('Error fetching posts for category "$categoryLabel": $e');
      Get.snackbar('Error', 'Failed to load category posts.');
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
  
  @override
  void onInit() {
    super.onInit();
    posts.clear();
  }
}
