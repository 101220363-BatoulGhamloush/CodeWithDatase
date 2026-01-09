import 'package:coffee_shop_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({required this.onCheckout, required this.subtotal, super.key});
  double subtotal;
  void Function() onCheckout;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Text(
                  'Subtotal',
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 132, 96, 70),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Spacer(),
                Text(
                  '\$ ${widget.subtotal}',
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 132, 96, 70),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: widget.onCheckout,

              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 96, 70),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
