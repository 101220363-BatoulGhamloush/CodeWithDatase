import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/screens/tabs.dart';
import 'package:flutter/material.dart';

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  List<Drink> favDrinks = [];
  List<CartItem> cart = [];
  @override
  Widget build(BuildContext context) {
    return Tabs(favoritesList: favDrinks, cartItems: cart);
  }
}
