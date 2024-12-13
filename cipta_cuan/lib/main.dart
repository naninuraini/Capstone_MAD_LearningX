import 'package:cipta_cuan/app/modules/notification/notification_servies.dart';
import 'package:cipta_cuan/widget/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);

  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  
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
            titleTextStyle: TextStyle(color: AppColors.white)),
        scaffoldBackgroundColor: AppColors.primary,
      ),
    );
  }
}
