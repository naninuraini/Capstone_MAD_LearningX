import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeWidget extends GetView<HomeController> {
  final MyUser? myUser;
  const HomeWidget({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, Selamat Datang!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          myUser!.name,
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Icon(
                        Icons.notifications_none,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Saldo",
                            style: TextStyle(
                              color: AppColors.textPurple,
                            ),
                          ),
                          Text(
                            myUser!.saldo.toString(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Pengeluaran",
                            style: TextStyle(
                              color: AppColors.textPurple,
                            ),
                          ),
                          Text(
                            "-1.187.400",
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: AppColors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                      minHeight: 25,
                    ),
                    Positioned(
                      left: 0.3 * 300 - 28,
                      child: Text(
                        '${(0.3 * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Text(
                      "Pengeluaran Anda ${(0.3 * 100).toStringAsFixed(0)}% Dari Total Saldo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF24325F),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
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
              Get.toNamed(Routes.TAMBAH_TRANSAKSI);
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
  }
}
