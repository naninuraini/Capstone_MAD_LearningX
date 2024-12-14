import 'package:cipta_cuan/app/modules/home/controllers/home_controller.dart';
import 'package:cipta_cuan/app/modules/home/widget/no_data.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MingguanTransaksi extends GetView<HomeController> {
  final MyUser? myUser;
  const MingguanTransaksi({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    controller.getPosts(myUser!.id);
      return NoDataWidgetHome(
        isLoading: controller.isLoading,
        transaction: controller.weeklyTransactions,
        judul: "Tidak Ada Data Minggu Ini",
        deskripsi: "Datanya diminggu ini gak ada, Mungkin\nkamu belum menambahkan data diminggu ini",
        assetsString: "assets/images/no_data/home.png",
      );
  }
}
