import 'package:coffee_shop_app/db/Cart_Storage.dart';
import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    required this.onIncrement,
    required this.onDecrement,
    required this.cartItems,
    required this.cartItem,
    required this.onDelete,
    super.key,
  });
  final CartItem cartItem;
  final List<CartItem> cartItems;
  final void Function() onIncrement;
  final void Function() onDecrement;
  final void Function() onDelete;


  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(
        widget.cartItem.id,
      ),
      onDismissed: (direction) async {
        await CartStorage().deleteCartItem(widget.cartItem.id);
       widget.onDelete;
       
      },
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(35),
                child: Image.asset(
                  widget.cartItem.drink.imagePath,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.drink.name,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$ ${(widget.cartItem.totalcost * widget.cartItem.numberOfItems).toStringAsFixed(1)}',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              IconButton(
                onPressed: widget.onDecrement,
                icon: Icon(Icons.remove, size: 20),
              ),
              Container(
                width: 30,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 132, 96, 70),
                ),
                child: Center(
                  child: Text(
                    '${widget.cartItem.numberOfItems}',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.onIncrement,
                icon: Icon(Icons.add, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
