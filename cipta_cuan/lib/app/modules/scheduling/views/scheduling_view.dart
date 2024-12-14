import 'dart:developer';

import 'package:cipta_cuan/app/modules/scheduling/widget/calender.dart';
import 'package:cipta_cuan/app/modules/scheduling/widget/card_jadwal.dart';
import 'package:cipta_cuan/widget/button.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../widget/getuser_controller.dart';
import '../../../../widget/no_data.dart';
import '../../tambah_jadwal/bindings/tambah_jadwal_binding.dart';
import '../../tambah_jadwal/views/tambah_jadwal_view.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingView extends StatefulWidget {
  const SchedulingView({super.key});

  @override
  _SchedulingViewState createState() => _SchedulingViewState();
}

class _SchedulingViewState extends State<SchedulingView> {
  final SchedulingController controller = Get.put(SchedulingController());
  final GetUserController getUserController = Get.find<GetUserController>();

  @override
  void dispose() {
    super.dispose();
    controller.selectedJadwal.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getUserController.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          getUserController.fetchUser(user.uid);
          return Obx(() {
            final myUser = getUserController.user.value;
            if (myUser != null) {
              controller.getJadwal(myUser.id, controller.selectedTanggal);
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Penjadwalan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                floatingActionButton: Material(
                  elevation: 10.0,
                  shape: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0DA6C2),
                          Color(0xFF0E39C6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(
                          () => TambahJadwalView(myUser: myUser),
                          binding: TambahJadwalBinding(),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      elevation: 0.0,
                      focusElevation: 0.0,
                      highlightElevation: 0.0,
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    const SizedBox(height: 10),
                    CalendarWidget(myUser: myUser),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF24325F),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50),
                          ),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.all(30),
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jadwal Tagihan",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFE1E1E1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                      onPressed: () {
                                        controller.wantDelete.value =
                                            !controller.wantDelete.value;
                                        if (!controller.wantDelete.value) {
                                          controller.selectedForDeletion
                                              .clear();
                                        }
                                      },
                                      icon: SvgPicture.asset(
                                          "assets/icons/trash.svg")),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Obx(() {
                                if (controller.selectedJadwal.isEmpty) {
                                  return NoDataWidget(
                                      judul: "Ga Ada tagihan di hari ini!",
                                      deskripsi:
                                          "Karena kamu belum ada tagihan\nKamu tidak perlu mengeluarkan tagihan apapun",
                                      assetsString:
                                          "assets/images/no_data/schedule.png");
                                }
                                return Obx(
                                  () {
                                    return Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.selectedJadwal.length,
                                          itemBuilder: (context, index) {
                                            final jadwal = controller
                                                .selectedJadwal[index];
                                            return CardJadwal(
                                              jadwal: jadwal,
                                              wantDelete: controller.wantDelete,
                                            );
                                          },
                                        ),
                                        if (controller.wantDelete.value)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ButtonWidget(
                                                  onPressed:
                                                      controller.deleteSelected,
                                                  title: "Hapus")),
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              log("Waiting for user data...");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Terjadi kesalahan: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: Text('Tidak ada data pengguna.'),
          );
        }
      },
    );
  }
}
