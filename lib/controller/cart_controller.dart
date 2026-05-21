import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  late Box<ProductModel> _cartBox;
  final carts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _cartBox = Hive.box<ProductModel>('favorites');
    _loadCart();
  }

  void _loadCart() {
    carts.assignAll(_cartBox.values.toList());
  }

  bool isCart(int id) {
    return carts.any((item) => item.id == id);
  }

  void toggleCart(Map<String, dynamic> product) {
    final id = product['id'];
    if (isCart(id)) {
      _cartBox.delete(id);
      Get.snackbar(
        'Dihapus',
        '${product['title']} dihapus dari favorit',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final price = (product['price'] ?? 0).toDouble();
      final image = product['image'] ?? '';
      final rating = (product['rating']?['rate'] ?? 0).toDouble();
      _cartBox.put(
        id,
        ProductModel(
          id: id,
          title: product['title'] ?? '',
          price: price,
          rating: rating,
          image: image,
        ),
      );
      Get.snackbar(
        'Ditambahkan',
        '${product['title']} ditambahkan ke keranjang',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loadCart();
  }

  void removeFromCart(ProductModel product) {
    product.delete();
    _loadCart();
    Get.snackbar(
      'Dihapus',
      '${product.title} dihapus dari keranjang',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
