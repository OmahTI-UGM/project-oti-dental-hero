import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/features/home/presentation/widget/day_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityCard extends StatelessWidget {
  final bool isActive;
  ActivityCard({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: shadeBlueColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '11 Agustus 2023',
                  style: GoogleFonts.fredoka(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: shadeBlueColor),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    DayCard(
                      isCompleted: true,
                      time: 'day',
                    ),
                    Spacer(),
                    DayCard(
                      isCompleted: false,
                      time: 'night',
                    ),
                  ],
                )
              ],
            ))
        : Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: lightBlueColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '11 Agustus 2023',
                  style: GoogleFonts.fredoka(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: purpleColor),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/day_bw.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 115,
                      height: 135,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: shadeGrayColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: purpleColor,
                                ),
                              ),
                              height: 40,
                              child: Center(
                                  child: OutlineText(
                                color: Colors.white,
                                text: 'Belum',
                                size: 18,
                                outlineColor: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/night_bw.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 115,
                      height: 135,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: shadeGrayColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: purpleColor,
                                ),
                              ),
                              height: 40,
                              child: Center(
                                  child: OutlineText(
                                color: Colors.white,
                                text: 'Belum',
                                size: 18,
                                outlineColor: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }
}
