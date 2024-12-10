import 'package:cipta_cuan/app/modules/home/controllers/home_controller.dart';
import 'package:cipta_cuan/app/modules/home/widget/no_data.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BulananTransaksi extends GetView<HomeController> {
  final MyUser? myUser;
  const BulananTransaksi({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    controller.getPosts(myUser!.id);
      return NoDataWidget(
        isLoading: controller.isLoading,
        transaction: controller.monthlyTransactions,
        judul: "Tidak Ada Data Bulan Ini",
        deskripsi:
            "Datanya dibulan ini gak ada, Mungkin\nkamu belum menambahkan data dibulan ini",
        assetsString: "assets/images/no_data/home.png",
      );
  }
}
