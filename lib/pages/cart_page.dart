import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi_produk/controller/cart_controller.dart';
import 'package:responsi_produk/routes/app_route.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Obx(() {
          if (cartController.carts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada favorit',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: cartController.carts.length,
            itemBuilder: (context, index) {
              final cart = cartController.carts[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: cart.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            cart.image,
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.tv, color: Colors.white),
                  title: Text(
                    cart.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                            children: [
                              const Icon(
                                Icons.currency_bitcoin,
                                size: 14,
                                color: Colors.white,
                              ),
                              Text(
                                ' ${cart.price}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(
                            ' ${cart.rating}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.deepOrange),
                    onPressed: () => cartController.removeFromCart(cart),
                  ),
                  onTap: () =>
                      Get.toNamed(AppRoutes.detail, arguments: cart.id),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
