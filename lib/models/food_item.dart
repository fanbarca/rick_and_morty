import 'package:uuid/uuid.dart';

class FoodItem {
  final String id = Uuid().v4();
  final int category;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final double rating;
  final bool inStock;

  FoodItem(this.category, this.name, this.description, this.price, this.rating,
      this.inStock, this.imagePath);
}
