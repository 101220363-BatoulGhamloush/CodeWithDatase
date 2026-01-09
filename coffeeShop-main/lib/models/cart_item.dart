import 'package:uuid/uuid.dart';
import 'drink.dart';

class CartItem {
  CartItem({
    required this.drink,
    required this.numberOfItems,
    required this.totalcost,
    required this.selectedSize,
    String? id,
  }) : id = id ?? const Uuid().v4();
    
  final String id;
  final Drink drink;
  int numberOfItems;
  double totalcost;
  String selectedSize;
  

  Map<String, Object?> get cartMap {
    return {
      'id': id,
      'name': drink.name,
      'image': drink.imagePath,
      'price': totalcost,
      'quantity': numberOfItems,
      'size': selectedSize,
    };
  }
}

