import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/core/widgets/star.dart';
import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final String time;
  bool isCompleted;
  bool done = false;
  DayCard({super.key, required this.time, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$time.png'),
          fit: BoxFit.cover,
        ),
      ),
      width: 115,
      height: 135,
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
                  onTap: () {},
                ),
        ),
      ),
    );
  }
}
