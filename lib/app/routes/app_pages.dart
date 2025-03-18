import 'package:get/get.dart';

import '../modules/album_detail/bindings/album_detail_binding.dart';
import '../modules/album_detail/views/album_detail_view.dart';
import '../modules/authentication/forgetpassword/bindings/forgetpassword_binding.dart';
import '../modules/authentication/forgetpassword/views/forgetpassword_view.dart';
import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/register/bindings/register_binding.dart';
import '../modules/authentication/register/views/register_view.dart';
import '../modules/authentication/verificationotp/bindings/verificationotp_binding.dart';
import '../modules/authentication/verificationotp/views/verificationotp_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/menu/album/bindings/album_binding.dart';
import '../modules/menu/album/views/album_view.dart';
import '../modules/menu/foto/bindings/foto_binding.dart';
import '../modules/menu/foto/views/foto_view.dart';
import '../modules/menu/home/bindings/home_binding.dart';
import '../modules/menu/home/views/home_view.dart';
import '../modules/menu/like/bindings/like_binding.dart';
import '../modules/menu/like/views/like_view.dart';
import '../modules/menu/profile/bindings/profile_binding.dart';
import '../modules/menu/profile/views/profile_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATIONOTP,
      page: () => const VerificationotpView(),
      binding: VerificationotpBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: DashboardBinding(),
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
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetpasswordView(),
      binding: ForgetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ALBUM,
      page: () => const AlbumView(),
      binding: AlbumBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FOTO,
      page: () => const FotoView(),
      binding: FotoBinding(),
    ),
    GetPage(
      name: _Paths.LIKE,
      page: () => const LikeView(),
      binding: LikeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ALBUM_DETAIL,
      page: () => const AlbumDetailView(),
      binding: AlbumDetailBinding(),
    ),
  ];
}
