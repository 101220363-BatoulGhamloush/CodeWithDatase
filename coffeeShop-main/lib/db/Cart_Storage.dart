import 'package:coffee_shop_app/data/drinks_data.dart';
import 'package:coffee_shop_app/db/database.dart';
import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/models/drink.dart';
class CartStorage {
 
Future<void> inserCartItem(CartItem item) async{
   final db= await CoffeeDatabase().getDatabase();
  await db.insert('cart',item.cartMap );
}
   Future<List<CartItem>> loadCartItems() async {
  final db = await CoffeeDatabase().getDatabase();

  final result = await db.query('cart');

  return result.map((row) {
    final drinkId = row['drink_id'] as int;

    // نجيب المشروب من اللست الأساسية
    final drink = drinks.firstWhere(
      (d) => d.id == drinkId,
    );

    return CartItem(
      id: row['id'] as int, // cart item id
      drink: drink,
      selectedSize: row['size'] as String,
      numberOfItems: row['quantity'] as int,
      totalcost: row['total_price'] as double,
    );
  }).toList();
}

Future<CartItem?> getCartItem(int drinkId, String size) async {
  final db = await CoffeeDatabase().getDatabase();

  final result = await db.query(
    'cart',
    where: 'drink_id = ? AND size = ?',
    whereArgs: [drinkId, size],
  );

  if (result.isEmpty) return null;

  final row = result.first;

  final drink = drinks.firstWhere((d) => d.id == drinkId);

  return CartItem(
    id: row['id'] as int,          
    drink: drink,
    selectedSize: row['size'] as String,
    numberOfItems: row['quantity'] as int,
    totalcost: row['total_price'] as double,
  );
}

Future<void> updateCartItem(int id, int newQuantity) async {
  final db = await CoffeeDatabase().getDatabase();

  await db.update(
    'cart',
    {'quantity': newQuantity},
    where: 'id = ?',
    whereArgs: [id],
  );
}

  // Delete a CartItem
  Future<void> deleteCartItem(String id) async {
    final db= await CoffeeDatabase().getDatabase();
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  }

