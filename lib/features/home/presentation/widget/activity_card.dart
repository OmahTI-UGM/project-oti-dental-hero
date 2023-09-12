import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/date_formatter.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/home/presentation/widget/day_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityCard extends StatelessWidget {
  final bool isActive;
  final DateTime date;
  final List<ActivityEntity> activityGroup;

  const ActivityCard({
    super.key,
    required this.isActive,
    required this.date,
    required this.activityGroup,
  });

  @override
  Widget build(BuildContext context) {
    return isActive
        ? _buildActiveCard(context, activityGroup)
        : _buildInactiveCard(context, activityGroup);
  }

  _buildActiveCard(BuildContext context, List<ActivityEntity> activityGroup) {
    final dayActivity = activityGroup
        .where((element) => element.timeState == TimeState.day)
        .first;

    final nightActivity = activityGroup
        .where((element) => element.timeState == TimeState.night)
        .first;

    print('dayActivity: $dayActivity\nnightActivity: $nightActivity');

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: shadeBlueColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormatter.homeScreenDate(date),
              style: GoogleFonts.fredoka(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: shadeBlueColor),
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                DayCard(
                  isCompleted: true,
                  time: TimeState.day,
                ),
                Spacer(),
                DayCard(
                  isCompleted: false,
                  time: TimeState.night,
                ),
              ],
            )
          ],
        ));
  }

  _buildInactiveCard(BuildContext context, List<ActivityEntity> activityGroup) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: lightBlueColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormatter.homeScreenDate(date),
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/day_bw.png'),
                      fit: BoxFit.fill,
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/night_bw.png'),
                      fit: BoxFit.contain,
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
    ;
  }
}
