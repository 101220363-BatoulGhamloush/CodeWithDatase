import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/widgets/fav_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorites extends StatefulWidget {
  const Favorites({required this.favoritesList, super.key});
  final List<Drink> favoritesList;

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Favorite Drinks',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return FavCard(
                  drink: widget.favoritesList[i],
                  fav: widget.favoritesList,
                );
              },
              itemCount: widget.favoritesList.length,
            ),
          ),
        ],
      ),
    );
  }
}
