import 'dart:developer';

import 'package:cipta_cuan/widget/constant.dart';
import 'package:cipta_cuan/widget/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CipCuanApps());
}

class CipCuanApps extends StatelessWidget {
  CipCuanApps({super.key});

  final authC = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          log("$snapshot");
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Cipta Cuan",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.HOME
                    : Routes.LOGIN,
            getPages: AppPages.routes,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary,
                titleTextStyle: TextStyle(color: AppColors.white)
              ),
              scaffoldBackgroundColor: AppColors.primary,
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
