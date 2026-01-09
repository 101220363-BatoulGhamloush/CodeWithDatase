import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/screens/cart.dart';
import 'package:coffee_shop_app/screens/favorites.dart';
import 'package:coffee_shop_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tabs extends StatefulWidget {
  const Tabs({required this.cartItems, required this.favoritesList, super.key});
  final List<Drink> favoritesList;
  final List<CartItem> cartItems;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomePage(
      favList: widget.favoritesList,
      cart: widget.cartItems,
    );
    if (_selectedPageIndex == 0) {
      activePage = HomePage(
        favList: widget.favoritesList,
        cart: widget.cartItems,
      );
    } else if (_selectedPageIndex == 1) {
      activePage = Favorites(favoritesList: widget.favoritesList);
    } else if (_selectedPageIndex == 2) {
      activePage = Cart(cartItems: widget.cartItems);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 253, 249, 249),
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedLabelStyle: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
        unselectedLabelStyle: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
        selectedItemColor: Color.fromARGB(255, 132, 96, 70),
        unselectedItemColor: Color.fromARGB(255, 214, 211, 211),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
