import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class InstructionCard extends StatelessWidget {
  int index;
  String text;
  String image;
  InstructionCard(
      {super.key,
      required this.index,
      required this.text,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.245,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: purpleColor, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$index.',
                  style: GoogleFonts.fredoka(
                    color: purpleColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Expanded(
                    child: Text(
                      text,
                      style: GoogleFonts.fredoka(
                        color: purpleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.25,
            ),
          ],
        ),
      ),
    );
  }
}
