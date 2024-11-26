import 'package:get/get.dart';

class ProfilAvatarController extends GetxController {
  int selectedIndex = 0;
  RxInt? tempSelectedIndex;

  void selectAvatar(int index) {
    if (selectedIndex == index) {
      selectedIndex = 0;
    } else {
      selectedIndex = index;
    }
    update();
  }

  void saveAvatar() {
    Get.snackbar(
      "Sukses",
      "Avatar berhasil dipilih!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
