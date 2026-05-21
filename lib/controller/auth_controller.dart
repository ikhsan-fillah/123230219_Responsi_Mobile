import 'package:get/get.dart';
import 'package:responsi_produk/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final email = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? '';
  }

  Future<void> login(String user, String password) async {
    if (user.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Gagal',
        'email dan password wajib diisi!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', user);
    email.value = user;
    isLoading.value = false;

    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    email.value = '';

    Get.offAllNamed(AppRoutes.login);
  }
}
