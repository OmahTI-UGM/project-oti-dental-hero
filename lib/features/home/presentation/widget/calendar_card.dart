import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarCard extends StatelessWidget {
  final int index;
  final List<ActivityEntity> activityGroup;

  const CalendarCard({
    super.key,
    required this.index,
    required this.activityGroup,
  });

  @override
  Widget build(BuildContext context) {
    final dayActivity = activityGroup
        .where((element) => element.timeState == TimeState.day)
        .first;

    final nightActivity = activityGroup
        .where((element) => element.timeState == TimeState.night)
        .first;

    return Container(
      width: MediaQuery.of(context).size.width * 0.167 + 20,
      height: MediaQuery.of(context).size.width * 0.167 +
          80, // Set the desired height here
      margin: const EdgeInsets.all(8), // Add margin between items
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$index',
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: shadeBlueColor,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isCompleted(dayActivity, TimeState.day,
                    MediaQuery.of(context).size.width * 0.06),
                _isCompleted(nightActivity, TimeState.night,
                    MediaQuery.of(context).size.width * 0.06),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _isCompleted(
      ActivityEntity activity, TimeState timeState, double width) {
    String image = timeState == TimeState.day
        ? 'assets/images/day-square.png'
        : 'assets/images/night-square.png';

    if (activity.score != null) {
      return Image.asset(image, width: width);
    } else {
      return const SizedBox.shrink();
    }
  }
}
