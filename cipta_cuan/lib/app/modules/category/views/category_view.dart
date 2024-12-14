import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/getuser_controller.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetUserController getUserController = Get.find<GetUserController>();
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
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                      itemCount: controller.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return GestureDetector(
                          onTap: () {
                            controller.filterPostsByCategory(
                                category['label']!, myUser);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    category['icon']!,
                                    width: 30,
                                    height: 35,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  category['label']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
        });
  }
}
