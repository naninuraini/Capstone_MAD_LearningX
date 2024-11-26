import 'package:cipta_cuan/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_avatar_controller.dart';

class ProfilAvatarView extends GetView<ProfilAvatarController> {
  const ProfilAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Pilih Avatar Kamu",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF24325F),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<ProfilAvatarController>(
                  builder: (controller) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        bool isSelected = controller.selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            controller.selectAvatar(index);
                          },
                          onDoubleTap: () {
                            controller.selectAvatar(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: isSelected
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xFF0DA6C2),
                                        Color(0xFF0E39C6)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/images/Avatar${index + 1}.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  onPressed: () {
                    controller.saveAvatar();
                  },
                  title: 'Simpan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
