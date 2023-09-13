import 'package:dental_hero/core/common/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  LeaderboardTile(
      {super.key, required this.rank, required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: purpleColor, width: 1.0))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
              child: Text(rank.toString(),
                  style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: purpleColor))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.52,
              child: Text(name,
                  style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: purpleColor))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.18,
              child: Text(
                score.toString(),
                style: GoogleFonts.fredoka(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: purpleColor),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
