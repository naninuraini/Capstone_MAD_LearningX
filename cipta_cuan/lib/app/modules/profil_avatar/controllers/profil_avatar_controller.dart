import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfilAvatarController extends GetxController {
  int selectedIndex = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid ?? " ";

  void selectAvatar(int index) {
    selectedIndex = index;
    update();
  }

  Future<void> saveAvatar() async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'avatar': selectedIndex + 1,
      });

      Get.back(result: true);
      Get.snackbar(
        "Sukses",
        "Avatar berhasil dipilih dan disimpan!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menyimpan avatar: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
