enum Size { small, medium, large }

enum Category { cappuccino, coldBrew, expresso }

class Drink {
  Drink({
    required this.name,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.size,
    required this.mainIng,
    required this.decaff,
    required this.lactoseFree,
    required this.sugarFree,
  });
  final String name;
  final String imagePath;
  final Category category;
  double price;
  Size size;
  final List<String> mainIng;
  final bool sugarFree;
  final bool lactoseFree;
  final bool decaff;
}
