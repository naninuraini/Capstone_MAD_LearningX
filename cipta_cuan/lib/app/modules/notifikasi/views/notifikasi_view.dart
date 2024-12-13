import 'package:cipta_cuan/app/modules/notifikasi/controllers/notifikasi_controller.dart';
import 'package:cipta_cuan/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.offAllNamed(Routes.HOME),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Notifikasi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            if (controller.notifications.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada notifikasi",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      notification['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notification['body']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeNotification(index);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
