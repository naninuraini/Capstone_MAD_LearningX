import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_list_controller.dart';

class CategoryListView extends StatelessWidget {
  final CategoryListController controller = Get.put(CategoryListController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final categoryLabel = arguments['category'] as String;

    controller.getCategoryPosts(categoryLabel);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori: $categoryLabel'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.categoryPosts.isEmpty) {
          return const Center(child: Text('Tidak ada transaksi untuk kategori ini.'));
        }
        return ListView.builder(
          itemCount: controller.categoryPosts.length,
          itemBuilder: (context, index) {
            final post = controller.categoryPosts[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(post.judul),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.deskripsi),
                    SizedBox(height: 4.0),
                    Text(
                      'Tanggal: ${post.tanggal.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                trailing: Text(
                  'Rp ${post.jumlah}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // 
                },
              ),
            );
          },
        );
      }),
    );
  }
}
