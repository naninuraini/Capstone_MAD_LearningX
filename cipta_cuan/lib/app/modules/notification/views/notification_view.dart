import 'dart:developer';

import 'package:cipta_cuan/app/modules/notification/controllers/notification_controller.dart';
import 'package:cipta_cuan/app/modules/notification/widget/card_notif.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/button.dart';

class NotificationView extends GetView<NotificationController> {
  final MyUser? myUser;

  NotificationView({required this.myUser});
  @override
  Widget build(BuildContext context) {
    controller.getJadwal(myUser!.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(Get.context!),
        ),
        title: const Text(
          "Daftar Notifikasi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.allJadwal.isEmpty) {
            log("Tidak ada notifikasi empty");
            return Center(child: Text('Tidak ada notifikasi'));
          }

          return ListView(
            shrinkWrap: false,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              CardNotif(jadwal: controller.allJadwal),
            ],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: controller.selectedForDeletion.length == 0
              ? SecondaryButton(
                  onPressed: () {},
                  title: "Hapus",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                )
              : ButtonWidget(
                  onPressed: controller.deleteSelected,
                  title: "Hapus",
                ),
        ),
      ),
    );
  }
}
