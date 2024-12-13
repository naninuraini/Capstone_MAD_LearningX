import 'package:cipta_cuan/app/modules/notifikasi/controllers/notifikasi_controller.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _initializeNotifications() async {
  // Android notification permission (for Android 13+)
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // iOS notification permission
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);
  await _initializeNotifications();
  Get.put(NotificationController());
  runApp(CipCuanApps());
}

class CipCuanApps extends StatelessWidget {
  CipCuanApps({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cipta Cuan",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          titleTextStyle: TextStyle(color: AppColors.white),
        ),
        scaffoldBackgroundColor: AppColors.primary,
      ),
    );
  }
}

// import 'package:cipta_cuan/widget/constant.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_local.dart';

// import 'app/routes/app_pages.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await initializeDateFormatting('id_ID', null);
//   runApp(CipCuanApps());
// }

// class CipCuanApps extends StatelessWidget {
//   CipCuanApps({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Cipta Cuan",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//       theme: ThemeData(
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         appBarTheme: AppBarTheme(
//             backgroundColor: AppColors.primary,
//             titleTextStyle: TextStyle(color: AppColors.white)),
//         scaffoldBackgroundColor: AppColors.primary,
//       ),
//     );
//   }
// }
