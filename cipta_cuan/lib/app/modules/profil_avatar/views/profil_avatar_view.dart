import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_avatar_controller.dart';

class ProfilAvatarView extends GetView<ProfilAvatarController> {
  const ProfilAvatarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Pilih Avatar Kamu",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF24325F),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
