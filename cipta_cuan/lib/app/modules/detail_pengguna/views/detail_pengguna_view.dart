import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaView extends GetView<DetailPenggunaController> {
  const DetailPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPenggunaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPenggunaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
