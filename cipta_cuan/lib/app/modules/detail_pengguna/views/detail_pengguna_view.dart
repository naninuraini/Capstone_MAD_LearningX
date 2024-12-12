import 'package:cipta_cuan/models/myUser/myuser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaView extends GetView<DetailPenggunaController> {
  const DetailPenggunaView({super.key});

  @override
  Widget build(BuildContext context) {
    final myUser = Get.arguments as MyUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(Get.context!),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Detail Pengguna",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Avatar${myUser.avatar}.png'),
                  backgroundColor: Colors.white,
                ),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1840),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF7B78AA),
                        size: 25,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.PROFIL_AVATAR);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            myUser.name.isNotEmpty ? myUser.name : "Nama tidak ditemukan",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF24325F),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  // Tambahkan detail lainnya di sini jika diperlukan
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _buildDetailItem(String title, String value) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Color(0xFF7B78AA),
//         ),
//       ),
//       const SizedBox(height: 8),
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF5F5F5), 
//           borderRadius: BorderRadius.circular(10), 
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFF7B78AA), 
//                 ),
//                 overflow: TextOverflow.ellipsis, 
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }



