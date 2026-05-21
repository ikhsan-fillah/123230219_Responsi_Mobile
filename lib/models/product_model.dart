import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.image,
  });
}
