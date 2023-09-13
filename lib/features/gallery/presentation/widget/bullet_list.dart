import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: GoogleFonts.fredoka(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: purpleColor),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: GoogleFonts.fredoka(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: purpleColor),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
