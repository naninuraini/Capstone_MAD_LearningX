import 'package:cipta_cuan/app/modules/detail_transaksi/views/detail_transaksi_view.dart';
import 'package:cipta_cuan/app/modules/home/controllers/home_controller.dart';
import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';


class HarianTransaksi extends GetView<HomeController> {
  final MyUser? myUser;
  const HarianTransaksi({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    controller.getPosts(myUser!.id);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.dailyTransactions.isEmpty) {
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: controller.dailyTransactions.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final post = controller.dailyTransactions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Navigasi ke halaman detail transaksi
                   Get.toNamed(
                    Routes.DETAIL_TRANSAKSI,
                    arguments: {'post': post},
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF0DA6C2),
                            Color(0xFF0E39C6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Color(0xFF375DFB),
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset("assets/images/history/transport.png"),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.judul,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                post.deskripsi,
                                style: TextStyle(
                                  color: AppColors.textPurple,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    post.kategori == 'pemasukan'
                                        ? "+ " +
                                            controller.formatRupiah(post.jumlah)
                                        : "- " +
                                            controller.formatRupiah(post.jumlah),
                                    style: TextStyle(
                                      color: post.kategori == 'pemasukan'
                                          ? AppColors.lightGreen
                                          : AppColors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("MMM d, yyyy", "id_ID")
                                        .format(post.tanggal),
                                    style: TextStyle(
                                      color: AppColors.textPurple,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              SvgPicture.asset("assets/icons/arrow.svg")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
