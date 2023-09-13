import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final double width;
  bool blue = true;
  final Function() onTap;
  Button({
    super.key,
    required this.text,
    required this.width,
    this.blue = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: blue
            ? BoxDecoration(
                color: shadeBlueColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.40),
                    offset: const Offset(4, -4),
                    blurRadius: 0,
                    spreadRadius: 0,
                    inset: true,
                  ),
                ],
              )
            : BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                ),
              ),
        width: width,
        height: 50,
        child: Center(
            child: OutlineText(
          color: Colors.white,
          text: text,
          size: 22,
          fontWeight: FontWeight.w600,
          outlineColor: purpleColor,
        )),
      ),
    );
  }
}
