import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes/app_pages.dart';
import '../controllers/category_list_controller.dart';

class CategoryListView extends StatelessWidget {
  CategoryListView({Key? key});

  @override
  Widget build(BuildContext context) {
    final CategoryListController controller = Get.put(CategoryListController());
    final arguments = Get.arguments as Map<String, dynamic>;
    final categoryLabel = arguments['category'] as String;
    final myUserLabel = arguments['myUser'] as MyUser;

    controller.getCategoryPosts(myUserLabel.id, categoryLabel);

    return Scaffold(
      backgroundColor: const Color(0xFF19173D),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(Get.context!),
        ),
        title: Text(
          'Transaksi $categoryLabel',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF19173D),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada transaksi untuk kategori ini',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Jarak tambahan di bawah AppBar
              Expanded(
                child: ListView.builder(
                  itemCount: controller.posts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    final category = controller.categories.firstWhere(
                      (cat) => cat["label"] == post.kategori,
                      orElse: () => {"icon": "", "label": ""},
                    );

                    return GestureDetector(
                      onTap: () {
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
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0DA6C2),
                                    Color(0xFF0E39C6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: const Color(0xFF375DFB),
                                  width: 1.0,
                                ),
                              ),
                              child: category["icon"]!.isNotEmpty
                                  ? Image.asset(
                                      category["icon"]!,
                                      width: 36,
                                      height: 36,
                                    )
                                  : const Icon(
                                      Icons.category,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width / 3 + 10,
                                        child: Text(
                                          post.judul,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 3,
                                        child: Text(
                                          post.deskripsi,
                                          style: const TextStyle(
                                            color: Color(0xFFB6B6D6),
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
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
                                                ? "+ " + controller.formatRupiah(post.jumlah, 'Rp')
                                                : "- " + controller.formatRupiah(post.jumlah, 'Rp'),
                                            style: TextStyle(
                                              color: post.kategori == 'Tabungan'
                                                  ? const Color(0xFF0FC672)
                                                  : const Color(0xFFE74C3C),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("MMM d, yyyy", "id_ID")
                                                .format(post.tanggal),
                                            style: const TextStyle(
                                              color: Color(0xFFB6B6D6),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      SvgPicture.asset("assets/icons/arrow.svg"),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
