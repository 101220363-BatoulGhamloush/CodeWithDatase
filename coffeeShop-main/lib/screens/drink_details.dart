import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/models/drink.dart';

import 'package:coffee_shop_app/widgets/size_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DrinkDetails extends StatefulWidget {
  DrinkDetails({
    required this.cart,
    required this.favoriteDrinks,
    required this.drink,
    super.key,
  });
  Drink drink;
  List<Drink> favoriteDrinks;
  List<CartItem> cart;

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  String selectedSize = "Small";
  double? oprice;
  double? cost;

  @override
  initState() {
    super.initState();
    oprice = widget.drink.price;
    cost = oprice;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    bool isFavorite = widget.favoriteDrinks.contains(widget.drink);

    final Map<Category, String> map = {
      Category.cappuccino: "Cappuccino",
      Category.coldBrew: "Cold Brew",
      Category.expresso: "Expresso",
    };
    final Map<String, String> map2 = {
      'Coffee Beans': '☕',
      'Decaf Coffee Beans': '☕',
      'Milk': '🥛',
      'Ice': '🧊',
      'Water': '💧',
      'Chocolate Syrup': '🍫',
      'Hazelnut Syrup': '🌰',
      'Coconut Milk': '🥥',
      'Nitrogen': '🧪',
      'Vanilla Syrup': '🌼',
      'Caramel Syrup': '🍯',
      'Foam': '🫧',
      'Almond Milk': '🌰🥛',
    };

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.4,
                child: Image.asset(widget.drink.imagePath, fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Image.asset(
                        'assets/back.png',
                        height: 36,
                        width: 36,
                      ),
                    ),
                  ),
                  SizedBox(height: 193),
                  Container(
                    height: 106,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(57, 0, 0, 0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.drink.name,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                map[widget.drink.category]!,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 27),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                widget.favoriteDrinks.remove(widget.drink);
                              } else {
                                widget.favoriteDrinks.add(widget.drink);
                              }
                            });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: const Color.fromARGB(255, 216, 215, 214),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Main Ingredients',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 28, 22, 22),
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.drink.mainIng.length,
                  (i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 219, 215, 214),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(map2[widget.drink.mainIng[i]].toString()),
                              Text(
                                widget.drink.mainIng[i],
                                style: GoogleFonts.lato(
                                  color: const Color.fromARGB(255, 28, 22, 22),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Coffee Size',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 28, 22, 22),
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                SizeButton(
                  onSelect: () {
                    setState(() {
                      selectedSize = "Small";
                      cost = oprice;
                    });
                  },
                  size: "Small",
                  isPressed: selectedSize == "Small",
                ),
                SizedBox(width: 10),
                SizeButton(
                  onSelect: () {
                    setState(() {
                      selectedSize = "Medium";
                      cost = oprice! + oprice! * (0.25);
                    });
                  },
                  size: "Medium",
                  isPressed: selectedSize == "Medium",
                ),
                SizedBox(width: 10),
                SizeButton(
                  onSelect: () {
                    setState(() {
                      selectedSize = "Large";
                      cost = oprice! + oprice! * (0.5);
                    });
                  },
                  size: "Large",
                  isPressed: selectedSize == "Large",
                ),
              ],
            ),
          ),
          SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.cart.add(
                    CartItem(
                      drink: widget.drink,
                      numberOfItems: 1,
                      totalcost: cost!,
                      selectedSize: selectedSize,
                    ),
                  );
                });
              },
              child: Container(
                width: 345,
                height: 73,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(132, 96, 70, 1),
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 50),
                    Text(
                      'Add to Cart',
                      style: GoogleFonts.lato(
                        fontSize: 20,

                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      height: 24,
                      width: 1,
                      color: Color.fromRGBO(248, 247, 250, 1),
                    ),
                    SizedBox(width: 25),
                    Text(
                      '\$ ${cost!.toStringAsFixed(1)}',
                      style: GoogleFonts.lato(
                        fontSize: 20,

                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
