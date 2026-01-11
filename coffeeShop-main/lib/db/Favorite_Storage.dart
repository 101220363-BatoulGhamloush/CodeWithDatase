
import 'package:coffee_shop_app/db/database.dart';
import 'package:coffee_shop_app/models/drink.dart';

class FavoriteStorage {
  // إضافة مشروب للمفضلة
 Future<void> insertFavorite(Drink drink) async {
    final db = await CoffeeDatabase().getDatabase();

    await db.insert('favorites', {
      'id': drink.id, // أو أي id مميز
      'name': drink.name,
      'image': drink.imagePath,
      'price': drink.price,
      'category': drink.category.name,
      'size': drink.size.name,
    });
  }

  // تحميل كل المفضلات
  Future<List<Drink>> loadFavorites() async {
    final db = await CoffeeDatabase().getDatabase();
    final result = await db.query('favorites');

    return result.map((row) {
      // تحويل size string لـ enum
      Size drinkSize;
      switch (row['size'] as String) {
        case 'small':
          drinkSize = Size.small;
          break;
        case 'medium':
          drinkSize = Size.medium;
          break;
        case 'large':
          drinkSize = Size.large;
          break;
        default:
          drinkSize = Size.small;
      }

      // تحويل category string لـ enum
      Category category = Category.values.firstWhere(
          (e) => e.name == (row['category'] as String),
          orElse: () => Category.cappuccino);

      return Drink(
        name: row['name'] as String,
        imagePath: row['image'] as String,
        price: row['price'] as double,
        category: category,
        size: drinkSize,
        mainIng: [], // ممكن تتركها فاضية أو تحفظها لاحقاً
        decaff: false,
        lactoseFree: false,
        sugarFree: false,
      );
    }).toList();
  }

  // حذف مشروب من المفضلة
  void deleteFavorite(String id) async {
    final db = await CoffeeDatabase().getDatabase();
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
