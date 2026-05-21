import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi_produk/controller/cart_controller.dart';
import 'package:responsi_produk/routes/app_route.dart';
import 'package:responsi_produk/services/product_service.dart';

class DetailPage extends StatelessWidget {
  final int productId;
  const DetailPage({super.key, required this.productId});

  String _stripHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Detail'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.cart),
            icon: Icon(Icons.shopping_bag_sharp),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<Map<String, dynamic>>(
          future: ProductServices.fetchProductDetail(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final product = snapshot.data!;
            final image = product['image'] ?? '';
            final title = product['title'] ?? 'No Title';
            final ratingRate = product['rating']?['rate'];
            final ratingCount = product['rating']?['count'];
            final rating = ratingRate != null
                ? '${ratingRate.toString()} (${ratingCount ?? 0})'
                : 'N/A';
            final price = product['price'];
            final category = product['category']?.toString() ?? 'N/A';
            final description = _stripHtml(
              product['description'] ?? 'Tidak ada deskripsi.',
            );

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image.isNotEmpty
                      ? Image.network(
                          image,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          height: 200,
                          child: Icon(Icons.tv, size: 80),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_bitcoin,
                              size: 14,
                              color: Colors.white,
                            ),
                            Text(
                              ' $price',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Flexible(
                              child: Text(
                                ' $rating',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  cartController.toggleCart(product),
                              label: Text(
                                cartController.isCart(productId)
                                    ? 'Sudah ada di keranjang'
                                    : 'Tambah ke keranjang',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
