import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupaPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LupaPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
