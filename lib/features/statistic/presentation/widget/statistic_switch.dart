import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/features/statistic/presentation/cubit/statistic_switch_cubit.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class StatisticSwitch extends StatelessWidget {
  const StatisticSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticSwitchCubit, StatisticSwitchState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<StatisticSwitchCubit>().switchToRank();
                },
                child: state == StatisticSwitchState.rank
                    ? Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: shadeBlueColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
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
                            ),
                          ),
                          const Center(
                            child: OutlineText(
                              text: 'Peringkatku',
                              size: 15,
                              color: Colors.white,
                              outlineColor: purpleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          border: Border.all(
                            color: purpleColor,
                          ),
                        ),
                        child: const Center(
                          child: Text('Peringkatku',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffABA8BD),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<StatisticSwitchCubit>().switchToStatistik();
                },
                child: state == StatisticSwitchState.rank
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          border: Border.all(
                            color: purpleColor,
                          ),
                        ),
                        child: const Center(
                          child: Text('Statistik',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffABA8BD),
                                  fontWeight: FontWeight.w600)),
                        ),
                      )
                    : Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: shadeBlueColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border:
                                  Border.all(color: purpleColor, width: 1.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.40),
                                  offset: const Offset(-4, -4),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  inset: true,
                                ),
                              ],
                            ),
                          ),
                          const Center(
                            child: OutlineText(
                              text: 'Statistik',
                              size: 15,
                              color: Colors.white,
                              outlineColor: purpleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
