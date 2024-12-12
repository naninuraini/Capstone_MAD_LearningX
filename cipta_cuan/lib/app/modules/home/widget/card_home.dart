import 'package:cipta_cuan/widget/constant.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/post/post_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class CardHome extends GetView<HomeController> {
  final RxList<Post> transaction;
  const CardHome({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        itemCount: transaction.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final post = transaction[index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail transaksi
              Get.toNamed(
                Routes.DETAIL_TRANSAKSI,
                arguments: {'post': post},
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 0.0),
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
                    child: Image.asset(
                      controller.categoryImages[post.kategori]!,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3 + 10 ,
                              child: Text(
                                post.judul,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                post.deskripsi,
                                style: TextStyle(
                                  color: AppColors.textPurple,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis
                                ),
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
                                  post.kategori == 'Tabungan'
                                      ? "+ " +
                                          controller.formatRupiah(post.jumlah, 'Rp')
                                      : "- " +
                                          controller.formatRupiah(post.jumlah, 'Rp'),
                                  style: TextStyle(
                                    color: post.kategori == 'Tabungan'
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
  }
}
