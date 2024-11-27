import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141231),
      appBar: AppBar(
        title: const Text(
          'Kategori',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF141231),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: controller.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return GestureDetector(
              onTap: () {
                // Navigasi ke halaman detail (nanti diimplementasikan)
                print("Tapped on ${category['label']}");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(12), 
                    ),
                    child: Center(
                      child: Image.asset(
                        category['icon']!,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
