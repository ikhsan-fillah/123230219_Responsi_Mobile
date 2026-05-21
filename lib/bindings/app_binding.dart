import 'package:get/get.dart';
import 'package:responsi_produk/controller/auth_controller.dart';
import 'package:responsi_produk/controller/cart_controller.dart';
import 'package:responsi_produk/controller/product_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}
