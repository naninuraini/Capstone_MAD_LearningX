import 'package:get/get.dart';
import '../../profil/controllers/profil_controller.dart';
import '../../../../models/myUser/myuser_model.dart';

class DetailPenggunaController extends GetxController {
  final ProfilController _profilController = Get.find<ProfilController>();

  Rx<MyUser> get user => _profilController.user;
}
