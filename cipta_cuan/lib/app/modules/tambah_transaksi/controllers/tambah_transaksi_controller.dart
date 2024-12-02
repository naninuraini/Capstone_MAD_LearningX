import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TambahTransaksiController extends GetxController {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  final formKeyTambahTransaksi = GlobalKey<FormState>();

  // Future<void> pickImage() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnedImage != null) {
  //     selectedImage = File(returnedImage.path);
  //     update();
  //   }
    // setState(() {
    // });
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
