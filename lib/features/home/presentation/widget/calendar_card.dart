import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.167 + 20,
      height: MediaQuery.of(context).size.width * 0.167 +
          80, // Set the desired height here
      margin: const EdgeInsets.all(8), // Add margin between items
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$index',
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: shadeBlueColor,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/night-square.png',
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Image.asset(
                  'assets/images/day-square.png',
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
