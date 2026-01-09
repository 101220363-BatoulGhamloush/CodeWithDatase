import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CategoryButton extends StatelessWidget {
  CategoryButton({
    required this.isTapped,
    required this.imgPath,
    required this.name,
    required this.onTap,
    super.key,
  });
  String imgPath;
  String name;
  bool isTapped;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 103,
        height: 37,
        decoration: BoxDecoration(
          color: isTapped ? Color.fromARGB(255, 132, 96, 70) : Colors.white,
          borderRadius: BorderRadius.circular(33),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  imgPath,
                  height: 16,
                  width: 16,
                  color: isTapped ? Colors.white : Colors.black,
                ),
                SizedBox(width: 5),
                Text(
                  name,
                  style: GoogleFonts.lato(
                    color: isTapped ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
