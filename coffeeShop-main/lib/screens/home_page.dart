
import 'package:coffee_shop_app/data/drinks_data.dart';
import 'package:coffee_shop_app/data/offers_data.dart';
import 'package:coffee_shop_app/db/Cart_Storage.dart';
import 'package:coffee_shop_app/db/Favorite_Storage.dart';
import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/models/drink.dart';
import 'package:coffee_shop_app/models/offer.dart';
import 'package:coffee_shop_app/screens/drink_details.dart';
import 'package:coffee_shop_app/screens/special_offer.dart';
import 'package:coffee_shop_app/widgets/Filter.dart';
import 'package:coffee_shop_app/widgets/category_button.dart';
import 'package:coffee_shop_app/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Filter { decaf, sugarFree, lactoseFree }

class HomePage extends StatefulWidget {
   HomePage({required this.cart,  required this.favList, super.key});
  List<Drink> favList;
  final List<CartItem> cart;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchText;
  List<Drink> drinksList = drinks;
  List<Offer> offersList = offers;
   Category selectedCategory = Category.cappuccino;
  List<Drink>? cappuccinoDrinks;
  List<Drink>? coldDrinks;
  List<Drink>? expressoDrinks;
  
  final FavoriteStorage favoriteStorage=FavoriteStorage();
 void increment(CartItem item) async {
  final newQuantity = item.numberOfItems + 1;

  await CartStorage().updateCartItem(item.id as int, newQuantity);

  setState(() {
    item.numberOfItems = newQuantity;
  });
}


  Future<void> loadCart() async{
    List<CartItem> item=await CartStorage().loadCartItems();
    setState(() {
      widget.cart.clear();
      widget.cart.addAll(item);
    });
  }
 
  Future<void> loadFavorites() async{
    final favs=await favoriteStorage.loadFavorites();
    setState(() {
      widget.favList=favs;
    });
  }
  
  
  void addtoFavorite(Drink drink) async{
     await favoriteStorage.insertFavorite(drink);
    loadFavorites();
  }
    
    
    Map<Filter, bool> _selectedFilters = {
       Filter.decaf: true,
      Filter.sugarFree: true,
       Filter.lactoseFree: true,
    };
  
  
   Future<void> addToCart(Drink drink) async {
  final storage = CartStorage();
  const selectedSize = "small";

  final existingItem =
      await storage.getCartItem(drink.name, selectedSize);

  if (existingItem == null) {
    // ⬅️ مش موجود → INSERT
    final newItem = CartItem(
      drink: drink,
      numberOfItems: 1,
      totalcost: drink.price,
      selectedSize: selectedSize,
      id: null,
    );

    await storage.inserCartItem(newItem);
  } else {
    
    await storage.updateCartItem(
      existingItem.id as int,
      existingItem.numberOfItems + 1,
    );
  }

  await loadCart();
}




  @override
  initState() {
    super.initState();
    loadCart();
    loadFavorites();
    }
  
   void _openFiltersSheet() async {
    final result = await showModalBottomSheet<Map<Filter, bool>>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Filters(currentFilters: _selectedFilters);
      },
    );

    setState(() {
      _selectedFilters =
          result ??
          {
            Filter.decaf: false,
            Filter.lactoseFree: false,
            Filter.sugarFree: false,
          };
    });
  }


  @override
  Widget build(BuildContext context) {
   
    final filteredDrinks = drinksList.where((drink) {
      // category filter
      if (drink.category != selectedCategory) return false;

      // decaf filter
      if (_selectedFilters[Filter.decaf]! && !drink.decaff) return false;

      // sugar free filter
      if (_selectedFilters[Filter.sugarFree]! && !drink.sugarFree) return false;

      // lactose free filter
      if (_selectedFilters[Filter.lactoseFree]! && !drink.lactoseFree)
        return false;

      return true;
    }).toList();
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sip Something Great",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 35),
          Container(
            width: 343,
            height: 53,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 247, 250),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color.fromARGB(255, 203, 203, 212),
                width: 1,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (searchText == null || searchText!.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter a drink name to search",
                            ),
                          ),
                        );
                        return;
                      }

                      final matchingDrinks = drinksList
                          .where(
                            (drink) => drink.name.toLowerCase().contains(
                              searchText!.toLowerCase().trim(),
                            ),
                          )
                          .toList();

                      if (matchingDrinks.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(
                              "Not Found",
                              style: GoogleFonts.lato(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: Text("No drink found with '$searchText'."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.lato(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,
                                maxHeight: 400,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: ItemCard(
                                                drink: matchingDrinks.first,
                                                onfavorite: addtoFavorite,
                                                onadd: addToCart,
                                              ),

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.lato(
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DrinkDetails(
                                                        cart: widget.cart,
                                                        favoriteDrinks:
                                                            widget.favList,
                                                        drink: matchingDrinks
                                                            .first,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'View Details',
                                              style: GoogleFonts.lato(
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.search, color: Colors.grey, size: 27),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        searchText = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Coffee..',
                        hintStyle: GoogleFonts.lato(
                          color: Color.fromARGB(255, 203, 203, 212),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  IconButton(
                      onPressed: _openFiltersSheet,
                    icon: Icon(
                      Icons.tune_rounded,
                      color: Color.fromARGB(255, 132, 96, 70),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 35),
          Text(
            "Categories",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 23),
          Row(
            children: [
              CategoryButton(
                name: "Cappuccino",
                imgPath: "assets/cappuccino.png",
                isTapped: selectedCategory == Category.cappuccino,
                onTap: () {
                  setState(() {
                     selectedCategory = Category.cappuccino;
                  });
                  }),
                 SizedBox(width: 17),
              CategoryButton(
                name: "Cold Brew",
                imgPath: "assets/vector.png",
                isTapped: selectedCategory ==Category.coldBrew,
                onTap: () {
                  setState(() {
                     selectedCategory = Category.coldBrew;
                  });}),
              SizedBox(width: 17),
              CategoryButton(
                name: "Expresso",
                imgPath: "assets/expresso.png",
                isTapped: selectedCategory == Category.expresso,
                onTap: () {
                  setState(() {
                    selectedCategory = Category.expresso;
                  });}),
               SizedBox(height: 10),
               Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(right: 18),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 0.86,
              ),
              itemCount: filteredDrinks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DrinkDetails(
                          cart: widget.cart,
                          favoriteDrinks: widget.favList,
                          drink: filteredDrinks[index],
                        ),
                      ),
                    );
                  },
                  child: ItemCard(
                            drink: filteredDrinks[index],
                            onfavorite: addtoFavorite,
                            onadd: addToCart,
                          ),

                );
              },
            ),
          ),
          SizedBox(height: 30),

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SpecialOffer(offersList: offersList),
                ),
              );
            },
            child: Container(
              height: 65,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      101,
                      100,
                      100,
                    ).withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "Explore special offers",
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 132, 96, 70),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Image.asset("assets/fire.png", height: 18, width: 18),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: const Color.fromARGB(255, 132, 96, 70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ]));
  }
}
