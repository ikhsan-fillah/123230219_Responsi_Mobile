import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_produk/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product_model.dart';
import 'bindings/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('favorites');

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getString('username') != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'N3tpl1k',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: AppBinding(),
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppRoutes.pages,
    );
  }
}
