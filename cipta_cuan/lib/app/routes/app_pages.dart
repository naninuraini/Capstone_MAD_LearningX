import 'package:get/get.dart';
import '../../models/myUser/myuser_model.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/category_list/bindings/category_list_binding.dart';
import '../modules/category_list/views/category_list_view.dart';
import '../modules/detail_pengguna/bindings/detail_pengguna_binding.dart';
import '../modules/detail_pengguna/views/detail_pengguna_view.dart';
import '../modules/detail_transaksi/bindings/detail_transaksi_binding.dart';
import '../modules/detail_transaksi/views/detail_transaksi_view.dart';
import '../modules/edit_transaksi/bindings/edit_transaksi_binding.dart';
import '../modules/edit_transaksi/views/edit_transaksi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/profil_avatar/bindings/profil_avatar_binding.dart';
import '../modules/profil_avatar/views/profil_avatar_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/scheduling/bindings/scheduling_binding.dart';
import '../modules/scheduling/views/scheduling_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tambah_jadwal/bindings/tambah_jadwal_binding.dart';
import '../modules/tambah_jadwal/views/tambah_jadwal_view.dart';
import '../modules/tambah_transaksi/bindings/tambah_transaksi_binding.dart';
import '../modules/tambah_transaksi/views/tambah_transaksi_view.dart';
import '../modules/tentang_kami/bindings/tentang_kami_binding.dart';
import '../modules/tentang_kami/views/tentang_kami_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(myUser: MyUser.empty),
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
      page: () => LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PENGGUNA,
      page: () => const DetailPenggunaView(),
      binding: DetailPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL_AVATAR,
      page: () => ProfilAvatarView(),
      binding: ProfilAvatarBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG_KAMI,
      page: () => const TentangKamiView(),
      binding: TentangKamiBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TRANSAKSI,
      page: () => TambahTransaksiView(myUser: MyUser.empty),
      binding: TambahTransaksiBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULING,
      page: () => SchedulingView(myUser: MyUser.empty),
      binding: SchedulingBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(myUser: MyUser.empty),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TRANSAKSI,
      page: () => const DetailTransaksiView(),
      binding: DetailTransaksiBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_LIST,
      page: () => CategoryListView(),
      binding: CategoryListBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_JADWAL,
      page: () => TambahJadwalView(myUser: MyUser.empty),
      binding: TambahJadwalBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_TRANSAKSI,
      page: () => EditTransaksiView(post: Get.arguments['post']),
      binding: EditTransaksiBinding(),
    ),
  ];
}
