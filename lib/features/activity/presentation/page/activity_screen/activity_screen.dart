import 'dart:async';

import 'package:dental_hero/core/widgets/video_background.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_state.dart';
import 'package:dental_hero/features/activity/presentation/page/result_screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityScreen extends StatelessWidget {
  int remainingTime = 0;
  final int seconds = 180;
  ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildBody(timerBloc, height, width),
    );
  }

  _buildBody(TimerBloc timerBloc, double height, double width) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (state is TimerInitial) {
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
                          icon: Icon(Icons.arrow_back), onPressed: () {}),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _startTimer(timerBloc, seconds);
                    },
                    child: const Text('Mulai'),
                  ),
                ],
              ),
            ),
          ]);
        } else if (state is TimerInProgress) {
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
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {},
                      ),
                      Center(
                          child: Text(
                              'Time remaining: ${state.currentDuration} seconds')),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/result', (route) => false,
                          arguments: remainingTime);
                    },
                    child: const Text('Selesai'),
                  ),
                ],
              ),
            ),
          ]);
        } else if (state is TimerStop) {
          return ResultScreen(
            duration: remainingTime,
          );
        }
        return Container();
      },
    );
  }

  void _startTimer(TimerBloc timerBloc, int duration) {
    timerBloc.add(StartTimer(duration));

    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerBloc.add(UpdateTimer(duration));
      remainingTime = duration;
      duration--;
      if (duration < 0) {
        timer.cancel();
      }
    });
  }
}
