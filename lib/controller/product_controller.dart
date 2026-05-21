import 'package:get/get.dart';
import 'package:responsi_produk/services/product_service.dart';

class ProductController extends GetxController {
  final products = <dynamic>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await ProductServices.fetchProducts();
      products.assignAll(data);
    } catch (e) {
      errorMessage.value = 'Gagal memuat data: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
