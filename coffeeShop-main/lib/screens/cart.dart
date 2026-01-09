import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:coffee_shop_app/widgets/cart_card.dart';
import 'package:coffee_shop_app/widgets/checkout_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_format/date_format.dart';

enum Location { beirut, sidon, nabatiye, tyre, baalbek, byblos }

class Cart extends StatefulWidget {
  const Cart({required this.cartItems, super.key});
  final List<CartItem> cartItems;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Location _selectedLocation = Location.beirut;
  DateTime? _selectedDate;

  double get subTotal {
    double subTotal = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      subTotal +=
          widget.cartItems[i].totalcost * widget.cartItems[i].numberOfItems;
    }
    return subTotal;
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = now.add(const Duration(days: 7));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cartItems.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No drinks yet.',
              style: GoogleFonts.lato(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            Text(
              'Start shopping now! ☕',
              style: GoogleFonts.lato(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 25,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Your Order",
            style: GoogleFonts.lato(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, i) {
                return CartCard(
                  cartItems: widget.cartItems,
                  cartItem: widget.cartItems[i],
                  onIncrement: () {
                    setState(() {
                      widget.cartItems[i].numberOfItems++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (widget.cartItems[i].numberOfItems > 1) {
                        widget.cartItems[i].numberOfItems--;
                      }
                    });
                  },
                  onDelete:(){
                    setState(() {
                      widget.cartItems.remove(widget.cartItems[i]);
                    });
                  },
                );
              },
            ),
          ),

          Row(
            children: [
              DropdownButton(
                value: _selectedLocation,

                items: Location.values.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(
                      location.name.toUpperCase(),
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 132, 96, 70),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatDate(_selectedDate!, [
                              dd,
                              '/',
                              mm,
                              '/',
                              yyyy,
                            ]),
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 132, 96, 70),
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color.fromARGB(255, 132, 96, 70),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          CheckoutCard(
            subtotal: subTotal,
            onCheckout: () {
              setState(() {
                widget.cartItems.clear();
              });

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(
                    'Order confirmed',
                    style: GoogleFonts.lato(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'OK',
                        style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 132, 96, 70),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
