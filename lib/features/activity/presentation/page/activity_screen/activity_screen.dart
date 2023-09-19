import 'package:dental_hero/core/common/color.dart';
import 'package:dental_hero/core/common/outline_text.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/widgets/button.dart';
import 'package:dental_hero/core/widgets/video_background.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/activity/activity_event.dart';

import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_state.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityScreen extends StatelessWidget {
  final int seconds;
  final TimeState? timeState;

  const ActivityScreen({
    super.key,
    this.timeState = TimeState.day,
    this.seconds = 180,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: _buildAppbar(height, width, context),
        bottomNavigationBar: _buildBottomNavbar(height, width, context),
        body: MultiBlocListener(
          listeners: [
            BlocListener<TimerBloc, TimerState>(
              listener: (context, state) {
                if (state is TimerStop) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/result', (route) => false,
                      arguments: state.currentDuration);
                  print(state.currentDuration);
                  _resetState(context);
                }
              },
            )
          ],
          // child: _buildBody(timerBloc, height, width),
          child: _buildBody(height, width),
        ));
  }

  // automaticallyImplyLeading: false,
  _buildAppbar(double height, double width, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffE9F3FF),
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xff6A658A), width: 1.0),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8.0),
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
            width: double.infinity,
            height: height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon_back.png',
                    ),
                    iconSize: 36,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Sikat Gigi",
                    style: GoogleFonts.fredoka(
                        color: purpleColor,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _buildBody(double height, double width) {
    return Stack(children: [
      Center(
        child: SizedBox(
            height: height * 0.8,
            width: width,
            child: VideoBackground(
              videoPath: 'assets/videos/Activity.mp4',
            )),
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
              if (state is TimerInitial) {
                return Container();
              }
              return OutlineText(
                text: '${state.currentDuration}',
                color: Colors.white,
                size: 36,
                fontWeight: FontWeight.w500,
                outlineColor: purpleColor,
              );
            }),
          ],
        ),
      ),
    ]);
  }

  _buildBottomNavbar(double height, double width, BuildContext context) {
    return Container(
      height: height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff6A658A), width: 1.0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            offset: Offset(4, -4),
            blurRadius: 0,
            spreadRadius: 0,
            inset: true,
          ),
        ],
      ),
      child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
        if (state is TimerInitial) {
          return ElevatedButton(
            onPressed: () {
              // _startTimer(BlocProvider.of<TimerBloc>(context), seconds)
              BlocProvider.of<TimerBloc>(context).add(StartTimer(seconds));
            },
            child: const Text('Mulai'),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Button(
            text: 'Selesai',
            width: double.infinity,
            onTap: () {
              final remainingTime = state.currentDuration;
              BlocProvider.of<TimerBloc>(context).add(StopTimer(remainingTime));

              BlocProvider.of<ActivityBloc>(context).add(SaveActivityEvent(
                  activity: ActivityEntity(
                date: DateTime.now(),
                duration: remainingTime,
                score: _countScore(remainingTime),
                userId: BlocProvider.of<AuthBloc>(context).state.user!.id,
                timeState: timeState,
              )));
            },
          ),
        );
      }),
    );
  }

  _countScore(int duration) {
    int maxDuration = 180;

    int score = 100 - (duration / maxDuration * 100).round();

    return score;
  }

  void _resetState(BuildContext context) {
    BlocProvider.of<TimerBloc>(context).add(ResetTimer());
    BlocProvider.of<ActivityBloc>(context).add(const ResetActivityEvent());
  }

  void _saveScore(state, context) {
    final remainingTime = state.currentDuration;
    BlocProvider.of<TimerBloc>(context).add(StopTimer(remainingTime));

    BlocProvider.of<ActivityBloc>(context).add(SaveActivityEvent(
        activity: ActivityEntity(
      date: DateTime.now(),
      duration: remainingTime,
      score: _countScore(remainingTime),
      userId: BlocProvider.of<AuthBloc>(context).state.user!.id,
      timeState: timeState,
    )));
  }
}
