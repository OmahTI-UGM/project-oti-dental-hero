import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoCard extends StatelessWidget {
  final String image;
  final String title;
  PhotoCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: purpleColor, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.fredoka(
                fontSize: 18, color: purpleColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
