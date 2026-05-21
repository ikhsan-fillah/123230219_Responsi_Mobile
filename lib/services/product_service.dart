import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductServices {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<dynamic>> fetchProducts() async{
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data produk');
    }
  }

  static Future<Map<String, dynamic>> fetchProductDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat detail produk');
    }
  }
}