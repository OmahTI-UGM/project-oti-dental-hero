import 'dart:async';

import 'package:dental_hero/core/constants/ticker.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial()) {
    on<StartTimer>(onStartTimer);
    on<UpdateTimer>(onUpdateTimer);
    on<StopTimer>(onStopTimer);
    on<ResetTimer>(onResetTimer);
  }
  void onStartTimer(event, emit) async {
    emit(TimerInProgress(event.duration));
    _tickerSubscription?.cancel();

    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(UpdateTimer(duration)));
  }

  void onUpdateTimer(event, emit) {
    print(event.currentDuration);

    emit(
      event.currentDuration > 0
          ? TimerInProgress(event.currentDuration)
          : TimerStop(event.currentDuration),
    );
  }

  void onStopTimer(event, emit) async {
    emit(TimerStop(event.currentDuration));
    _tickerSubscription?.cancel();
  }

  void onResetTimer(event, emit) async {
    emit(const TimerInitial());
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
