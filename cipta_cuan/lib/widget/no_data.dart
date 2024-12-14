import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String assetsString;
  const NoDataWidget({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.assetsString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(assetsString),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20),
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
}
