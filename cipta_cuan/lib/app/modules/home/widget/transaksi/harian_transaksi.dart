import 'package:cipta_cuan/app/modules/detail_transaksi/views/detail_transaksi_view.dart';
import 'package:cipta_cuan/app/modules/home/controllers/home_controller.dart';
import 'package:cipta_cuan/app/modules/home/widget/no_data.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';


class HarianTransaksi extends GetView<HomeController> {
  final MyUser? myUser;
  const HarianTransaksi({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    controller.getPosts(myUser!.id);
      return NoDataWidget(
        isLoading: controller.isLoading,
        transaction: controller.dailyTransactions,
        judul: "Tidak Ada Data Hari Ini",
        deskripsi:
            "Datanya dihari ini gak ada, Mungkin\nkamu belum menambahkan data dihari ini",
        assetsString: "assets/images/no_data/home.png",
      );
  }
}
