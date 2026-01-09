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
    return CartItem(
      id: row['id'] as String,  // لو استخدمنا id كـ int
      numberOfItems: row['quantity'] as int,
      totalcost: row['price'] as double,
      selectedSize: row['size'] as String,
      drink: Drink(
        name: row['name'] as String,
        imagePath: row['image'] as String,
        price: row['price'] as double,
        category: Category.cappuccino, // ممكن تحتاج طريقة لتحويل string لقيمة Category
        size: Size.small,               // نفس الشي للـ size
        mainIng: [],
        decaff: false,
        lactoseFree: false,
        sugarFree: false,
      ),
    );
  }).toList();
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
