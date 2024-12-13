import 'package:cipta_cuan/app/modules/notification/controllers/notification_controller.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/jadwal/jadwal_model.dart';

class CardNotif extends GetView<NotificationController> {
  final RxList<Jadwal> jadwal;
  const CardNotif({
    super.key,
    required this.jadwal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        itemCount: jadwal.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final jadwals = jadwal[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.blue,
                        side: BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        value: controller.selectedForDeletion.contains(jadwals),
                        onChanged: (value) {
                          controller.toggleSelection(jadwals);
                        },
                      ),
                    ),
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
                        "assets/images/notification.png",
                        width: 36,
                        height: 36,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // jadwals.judul,
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3 + 10,
                                child: Text(
                                  "Tagihan ${jadwals.judul}",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Text(
                                DateFormat("MMM d, yyyy", "id_ID")
                                    .format(jadwals.tanggalDanWaktu),
                                style: TextStyle(
                                  color: AppColors.textPurple,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          // jadwals.deskripsi,
                          Text(
                            "Ada tagihan ${jadwals.judul} yang harus kamu bayar sebelum jatuh tempo!",
                            style: TextStyle(
                              color: AppColors.lightBlue,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
