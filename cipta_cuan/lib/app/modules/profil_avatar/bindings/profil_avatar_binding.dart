import 'package:get/get.dart';

import '../controllers/profil_avatar_controller.dart';

class ProfilAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilAvatarController>(
      () => ProfilAvatarController(),
    );
  }
}
