import 'package:dental_hero/core/widgets/video_background.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_bloc.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

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
                      timerBloc.add(
                          StartTimer(10)); // Start countdown for 10 seconds
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
                    onPressed: () {},
                    child: const Text('Selesai'),
                  ),
                ],
              ),
            ),
          ]);
        } else if (state is CountdownCompleted) {
          return const Center(child: Text('Countdown Completed'));
        }
        return Container();
      },
    );
  }
}
