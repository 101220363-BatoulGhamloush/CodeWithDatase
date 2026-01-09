import 'package:coffee_shop_app/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavCard extends StatelessWidget {
  const FavCard({required this.fav, required this.drink, super.key});
  final Drink drink;
  final List<Drink> fav;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(drink.name),
      onDismissed: (direction) => fav.remove(drink),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(35),
                child: Image.asset(
                  drink.imagePath,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 34),
              Column(
                children: [
                  Text(
                    drink.name,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$ ${drink.price.toStringAsFixed(1)}',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
