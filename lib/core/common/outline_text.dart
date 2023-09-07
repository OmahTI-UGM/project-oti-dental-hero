import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlineText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Color outlineColor;
  final FontWeight fontWeight;
  const OutlineText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.outlineColor,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.fredoka(
            fontSize: size,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = outlineColor,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.fredoka(
            fontSize: size,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ],
    );
  }
}
