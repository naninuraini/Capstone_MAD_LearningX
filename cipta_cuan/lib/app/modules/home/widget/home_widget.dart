import 'dart:developer';
import 'dart:ui';

import 'package:cipta_cuan/app/modules/home/widget/transaksi/bulanan_transaksi.dart';
import 'package:cipta_cuan/app/modules/home/widget/transaksi/harian_transaksi.dart';
import 'package:cipta_cuan/app/modules/home/widget/transaksi/mingguan_transaksi.dart';
import 'package:cipta_cuan/app/modules/tambah_transaksi/bindings/tambah_transaksi_binding.dart';
import 'package:cipta_cuan/app/modules/tambah_transaksi/views/tambah_transaksi_view.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:cipta_cuan/widget/getuser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find<HomeController>();
  final GetUserController getUserController = Get.find<GetUserController>();

  @override
  void initState() {
    controller.tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.tabController.dispose();
    super.dispose();
  }

  Key _pageKey = UniqueKey();

  Future<void> _refreshData() async {
    setState(() {
      _pageKey = UniqueKey();
    });
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
              return Scaffold(
                key: _pageKey,
                body: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Halo, Selamat Datang!",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        myUser.name,
                                        style: TextStyle(
                                          color: AppColors.textPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Icon(
                                      Icons.notifications_none,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Saldo",
                                        style: TextStyle(
                                          color: AppColors.textPurple,
                                        ),
                                      ),
                                      Text(
                                        controller.formatRupiah(
                                            myUser.saldo, 'Rp'),
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    color: AppColors.white,
                                    thickness: 1.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Pengeluaran",
                                        style: TextStyle(
                                          color: AppColors.textPurple,
                                        ),
                                      ),
                                      Text(
                                        controller.formatRupiah(
                                            myUser.pengeluaran, '-'),
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxWidth = constraints.maxWidth;
                                final progress =
                                    controller.calculateExpensePercentage(
                                        myUser.saldo, myUser.pengeluaran);
                                final textWidth = 55.0;
                                return Stack(
                                  children: [
                                    Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final progress = controller
                                            .calculateExpensePercentage(
                                                myUser.saldo,
                                                myUser.pengeluaran);
                                        final progressWidth =
                                            constraints.maxWidth * progress;

                                        return Container(
                                          height: 25,
                                          width: progressWidth,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF0DA6C2),
                                                Color(0xFF0E39C6)
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      left:
                                          (progress * maxWidth - textWidth / 2)
                                              .clamp(0.0, maxWidth - textWidth),
                                      top: 5,
                                      child: Text(
                                        '${(controller.calculateExpensePercentage(myUser.saldo, myUser.pengeluaran) * 100).toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Text(
                                  "Pengeluaran Anda ${(controller.calculateExpensePercentage(myUser.saldo, myUser.pengeluaran) * 100).toStringAsFixed(0)}% Dari Total Saldo",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Flexible(
                          //   fit: FlexFit.loose,
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF24325F),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 40, 20, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        width: 350,
                                        height: 60,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: TabBar(
                                          controller: controller.tabController,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          indicatorPadding: EdgeInsets.zero,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF0DA6C2),
                                                Color(0xFF0E39C6)
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          dividerColor: Colors.transparent,
                                          labelColor: Colors.white,
                                          unselectedLabelColor: Colors.black,
                                          unselectedLabelStyle: TextStyle(
                                              fontWeight: FontWeight.w400),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          tabs: controller.tabs,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: TabBarView(
                                    controller: controller.tabController,
                                    children: [
                                      HarianTransaksi(myUser: myUser),
                                      MingguanTransaksi(myUser: myUser),
                                      BulananTransaksi(myUser: myUser),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                          () => TambahTransaksiView(myUser: myUser),
                          binding: TambahTransaksiBinding(),
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
