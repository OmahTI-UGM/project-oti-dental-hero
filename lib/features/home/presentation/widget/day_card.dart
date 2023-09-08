import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/widgets/star.dart';
import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final TimeState time;
  final bool isCompleted;
  final bool done = false;
  const DayCard({super.key, required this.time, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/${time.value}.png'),
          fit: BoxFit.fill,
        ),
      ),
      width: 114,
      height: 134,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: isCompleted
              ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14)
              : const EdgeInsets.all(8.0),
          child: isCompleted
              ? StarWidget(
                  star: 2,
                )
              : GestureDetector(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: shadeBlueColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: purpleColor,
                      ),
                    ),
                    height: 40,
                    child: const Center(
                        child: OutlineText(
                      color: Colors.white,
                      text: 'Mulai',
                      size: 18,
                      outlineColor: purpleColor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/activity', arguments: time);
                  },
                ),
        ),
      ),
    );
  }
}
