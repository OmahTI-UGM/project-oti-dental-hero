import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/widgets/video_background.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/activity/presentation/blocs/activity/activity_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/activity/activity_event.dart';

import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_state.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: MultiBlocListener(
      listeners: [
        BlocListener<TimerBloc, TimerState>(
          listener: (context, state) {
            if (state is TimerStop) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/result', (route) => false,
                  arguments: state.currentDuration);

              _resetState(context);
            }
          },
        )
      ],
      // child: _buildBody(timerBloc, height, width),
      child: _buildBody(height, width),
    ));
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
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back), onPressed: () {}),
                BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
                  if (state is TimerInitial) {
                    return Container();
                  }

                  return Center(
                    child: Text(
                        'Time remaining: ${state.currentDuration} seconds'),
                  );
                })
              ],
            ),
            BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
              if (state is TimerInitial) {
                return ElevatedButton(
                  onPressed: () {
                    // _startTimer(BlocProvider.of<TimerBloc>(context), seconds)
                    BlocProvider.of<TimerBloc>(context)
                        .add(StartTimer(seconds));
                  },
                  child: const Text('Mulai'),
                );
              }

              return ElevatedButton(
                onPressed: () {
                  final remainingTime = state.currentDuration;
                  BlocProvider.of<TimerBloc>(context)
                      .add(StopTimer(remainingTime));

                  BlocProvider.of<ActivityBloc>(context).add(SaveActivityEvent(
                      activity: ActivityEntity(
                    date: DateTime.now(),
                    duration: remainingTime,
                    score: _countScore(remainingTime),
                    userId: BlocProvider.of<AuthBloc>(context).state.user!.id,
                    timeState: timeState,
                  )));
                },
                child: const Text('Selesai'),
              );
            }),
          ],
        ),
      ),
    ]);
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
}
