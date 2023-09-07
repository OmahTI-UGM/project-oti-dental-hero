import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class FotoGigi extends StatelessWidget {
  final bool isCompleted;
  FotoGigi({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return isCompleted
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: shadeBlueColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_smile.png',
                        width: 41,
                      ),
                      const SizedBox(width: 4),
                      Text('Foto gigi',
                          style: GoogleFonts.fredoka(
                              fontSize: 18,
                              color: shadeBlueColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      width: 82,
                      decoration: BoxDecoration(
                        color: shadeBlueColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: purpleColor,
                        ),
                      ),
                      height: 50,
                      child: const Center(
                          child: OutlineText(
                        color: Colors.white,
                        text: 'Ambil',
                        size: 18,
                        outlineColor: purpleColor,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    onTap: () {},
                  ),
                ]),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_smile.png',
                        width: 41,
                      ),
                      const SizedBox(width: 4),
                      Text('Foto gigi',
                          style: GoogleFonts.fredoka(
                              fontSize: 18,
                              color: purpleColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      width: 82,
                      decoration: BoxDecoration(
                        color: shadeGrayColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade700),
                      ),
                      height: 50,
                      child: Center(
                          child: OutlineText(
                        color: Colors.white,
                        text: 'Sudah',
                        size: 18,
                        outlineColor: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    onTap: () {},
                  ),
                ]),
          );
  }
}
