import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SizeButton extends StatelessWidget {
  SizeButton({
    required this.isPressed,
    required this.onSelect,
    required this.size,
    super.key,
  });
  String size;
  bool isPressed;
  void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelect,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 37),
        backgroundColor: isPressed
            ? Color.fromARGB(255, 132, 96, 70)
            : Colors.white,
      ),
      child: Text(
        size,
        style: GoogleFonts.lato(
          color: isPressed
              ? const Color.fromARGB(255, 255, 253, 253)
              : const Color.fromARGB(255, 91, 91, 91),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
