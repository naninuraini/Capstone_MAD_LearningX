import 'package:cipta_cuan/app/modules/home/controllers/home_controller.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HarianTransaksi extends GetView<HomeController> {
  const HarianTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/no_data/home.png"),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: Text(
            "Tidak Ada Data Bulan Ini",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          "Datanya dibulan ini gak ada, Mungkin\nkamu belum menambahkan data dibulan ini",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w200,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
