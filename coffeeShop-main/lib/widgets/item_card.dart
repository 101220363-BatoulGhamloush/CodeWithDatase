import 'package:coffee_shop_app/db/Favorite_Storage.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.drink, required this.onadd,required this.onfavorite,super.key});
  final Drink drink;
  final void Function(Drink) onadd;
  final void Function(Drink) onfavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              drink.imagePath,
              width: double.infinity,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            drink.name,
            style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w600),
          ),

          Row(
            children: [
              Text(
                "\$${drink.price}",
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap:(){
                 onfavorite(drink);
                  onadd(drink);
                  },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 132, 96, 70),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
