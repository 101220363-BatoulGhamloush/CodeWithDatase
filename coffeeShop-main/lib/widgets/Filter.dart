import 'package:coffee_shop_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Filters extends StatefulWidget {
  const Filters({required this.currentFilters, super.key});
  final Map<Filter, bool> currentFilters;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool decafFilterSet = true;
  bool sugarFreeFilterSet = true;
  bool lactoseFreeFilterSet = true;

  @override
  void initState() {
    super.initState();
    decafFilterSet = widget.currentFilters[Filter.decaf]!;
    sugarFreeFilterSet = widget.currentFilters[Filter.sugarFree]!;
    lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SwitchListTile(
            activeColor: const Color.fromARGB(255, 223, 209, 203),
            activeTrackColor: Colors.brown,
            value: decafFilterSet,
            onChanged: (isChecked) {
              setState(() {
                decafFilterSet = isChecked;
              });
            },
            title: Text(
              'Decaf',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              'Only include decaf drinks.',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 132, 96, 70),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 30, right: 20),
          ),
          SizedBox(height: 10),
          SwitchListTile(
            activeColor: const Color.fromARGB(255, 223, 209, 203),
            activeTrackColor: Colors.brown,
            value: sugarFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                sugarFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Sugar Free',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              'Only include sugar free drinks.',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 132, 96, 70),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 30, right: 20),
          ),
          SizedBox(height: 10),
          SwitchListTile(
            activeColor: const Color.fromARGB(255, 223, 209, 203),
            activeTrackColor: Colors.brown,
            value: lactoseFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                lactoseFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Lactose Free',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              'Only include lactose free drinks.',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 132, 96, 70),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 30, right: 20),
          ),
          SizedBox(height: 35),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 245, 229, 218),
            ),
            onPressed: () {
              var result = {
                Filter.decaf: decafFilterSet,
                Filter.lactoseFree: lactoseFreeFilterSet,
                Filter.sugarFree: sugarFreeFilterSet,
              };
              Navigator.pop(context, result);
            },
            child: Text(
              'Apply filters',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 132, 96, 70),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}