import 'dart:developer';

import 'package:cipta_cuan/app/modules/scheduling/controllers/scheduling_controller.dart';
import 'package:cipta_cuan/models/jadwal/jadwal_model.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardJadwal extends GetView<SchedulingController> {
  final Jadwal jadwal;
  final RxBool wantDelete;
  const CardJadwal({
    super.key,
    required this.jadwal,
    required this.wantDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (wantDelete.value) {
              return Checkbox(
                value: controller.selectedForDeletion.contains(jadwal),
                onChanged: (value) {
                  controller.toggleSelection(jadwal);
              log("message: ${controller.selectedForDeletion}");
                },
              );
            }
            return SizedBox.shrink();
          }),
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
            child: Image.asset(
              "assets/category/jadwal.png",
              width: 36,
              height: 36,
            ),
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
                      jadwal.judul,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      jadwal.deskripsi,
                      style: TextStyle(
                        color: AppColors.textPurple,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.formatRupiah(jadwal.jumlah, 'Rp'),
                      style: TextStyle(
                        color: AppColors.lightBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      DateFormat("MMM d, yyyy", "id_ID")
                          .format(jadwal.tanggalDanWaktu),
                      style: TextStyle(
                        color: AppColors.textPurple,
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
