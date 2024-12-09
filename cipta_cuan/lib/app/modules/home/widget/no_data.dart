import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../models/post/post_model.dart';
import 'card_home.dart';

class NoDataWidget extends StatelessWidget {
  final RxBool isLoading;
  final RxList<Post> transaction;
  final String judul;
  final String deskripsi;
  final String assetsString;
  const NoDataWidget({
    super.key,
    required this.isLoading,
    required this.transaction,
    required this.judul,
    required this.deskripsi,
    required this.assetsString,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (transaction.isEmpty) {
        return Column(
          children: [
            Image.asset(assetsString),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 10),
              child: Text(
                judul,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              deskripsi,
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
      return CardHome(transaction: transaction);
    });
  }
}
