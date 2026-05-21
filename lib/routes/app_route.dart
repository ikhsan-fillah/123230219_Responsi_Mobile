import 'package:get/get.dart';
import 'package:responsi_produk/pages/cart_page.dart';
import 'package:responsi_produk/pages/detail_page.dart';
import 'package:responsi_produk/pages/login_page.dart';
import 'package:responsi_produk/widgets/bottom_nav.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const detail = '/detail';
  static const cart = '/cart';

  static final pages = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: home, page: () => const MainNavigation()),
    GetPage(
      name: detail,
      page: () => DetailPage(productId: Get.arguments as int),
    ),
    GetPage(
      name: cart,
      page: () => CartPage(),
    ),
  ];
}
