import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isActive;
  final bool isPast;
  final bool isLast;
  final Widget child;
  final int number;
  const CustomTimelineTile({
    super.key,
    required this.isFirst,
    required this.isActive,
    required this.isPast,
    required this.isLast,
    required this.child,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: grayColor, thickness: 1),
      afterLineStyle: const LineStyle(color: grayColor, thickness: 1),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(
            color: isActive ? shadeBlueColor : lightBlueColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: purpleColor, width: 2),
          ),
          child: Center(
              child: isActive
                  ? OutlineText(
                      color: Colors.white,
                      text: number.toString(),
                      size: 21,
                      outlineColor: purpleColor,
                      fontWeight: FontWeight.w600,
                    )
                  : Text(
                      number.toString(),
                      style: GoogleFonts.fredoka(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: purpleColor),
                    )),
        ),
      ),
      endChild: child,
    );
  }
}
