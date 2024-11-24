import 'package:get/get.dart';

import '../modules/detail_pengguna/bindings/detail_pengguna_binding.dart';
import '../modules/detail_pengguna/views/detail_pengguna_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/profil_avatar/bindings/profil_avatar_binding.dart';
import '../modules/profil_avatar/views/profil_avatar_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tentang_kami/bindings/tentang_kami_binding.dart';
import '../modules/tentang_kami/views/tentang_kami_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PENGGUNA,
      page: () => const DetailPenggunaView(),
      binding: DetailPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL_AVATAR,
      page: () => const ProfilAvatarView(),
      binding: ProfilAvatarBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG_KAMI,
      page: () => const TentangKamiView(),
      binding: TentangKamiBinding(),
    ),
  ];
}
