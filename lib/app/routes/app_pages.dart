import 'package:airsoftmarket/app/modules/auth/login/bindings/login_binding.dart';
import 'package:airsoftmarket/app/modules/auth/login/views/login_view.dart';
import 'package:airsoftmarket/app/modules/cart/bindings/cart_binding.dart';
import 'package:airsoftmarket/app/modules/cart/views/cart_screen.dart';
import 'package:airsoftmarket/app/modules/detailimage/bindings/image_binding.dart';
import 'package:airsoftmarket/app/modules/detailimage/views/image_view.dart';
import 'package:airsoftmarket/app/modules/detailproduct/bindings/detail_binding.dart';
import 'package:airsoftmarket/app/modules/detailproduct/views/detail_view.dart';
import 'package:airsoftmarket/app/modules/profile/bindings/profile_binding.dart';
import 'package:airsoftmarket/app/modules/profile/views/profile_view.dart';
import 'package:airsoftmarket/app/modules/splashscreen/bindings/splash_binding.dart';
import 'package:airsoftmarket/app/modules/splashscreen/view/splashscreen_view.dart';
import 'package:airsoftmarket/app/widget/bottomnav.dart';
import 'package:get/get.dart';

import 'package:airsoftmarket/app/modules/add/bindings/add_binding.dart';
import 'package:airsoftmarket/app/modules/add/views/add_view.dart';
import 'package:airsoftmarket/app/modules/edit/bindings/edit_binding.dart';
import 'package:airsoftmarket/app/modules/edit/views/edit_view.dart';
import 'package:airsoftmarket/app/modules/home/bindings/home_binding.dart';
import 'package:airsoftmarket/app/modules/home/views/home_view.dart';

import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.NAVBOTTOM,
      page: () => BottomNav(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(),
      binding: AddBinding(),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => EditView(),
      binding: EditBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE,
      page: () => ImageView(),
      binding: ImageBinding(),
    ),
  ];
}
