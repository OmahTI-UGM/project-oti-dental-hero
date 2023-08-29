import 'package:dental_hero/features/activity/presentation/blocs/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerEvent>((event, emit) {
      if (event is StartTimer) {
        emit(TimerInProgress(event.duration));
      }
    });
  }

  // Stream<TimerState> mapEventToState(TimerEvent event) async* {
  //   if (event is StartTimer) {
  //     yield* _mapStartCountdownToState(event);
  //   } else if (event is UpdateTimer) {
  //     yield* _mapUpdateCountdownToState(event);
  //   }
  // }

  // Stream<TimerState> _mapStartCountdownToState(StartTimer event) async* {
  //   for (int i = event.duration; i >= 0; i--) {
  //     yield TimerInProgress(i);
  //     await Future.delayed(const Duration(seconds: 1));
  //   }
  //   yield CountdownCompleted();
  // }

  // Stream<TimerState> _mapUpdateCountdownToState(UpdateTimer event) async* {
  //   yield TimerInProgress(event.currentDuration);
  // }
}
