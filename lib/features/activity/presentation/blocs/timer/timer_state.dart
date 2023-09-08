import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final Timer? timer;
  final int currentDuration;

  const TimerState({this.currentDuration = 0, this.timer});

  @override
  List<Object> get props => [
        currentDuration,
      ];
}

class TimerInitial extends TimerState {
  const TimerInitial() : super();

  @override
  List<Object> get props => [];
}

class TimerInProgress extends TimerState {
  const TimerInProgress(int currentDuration)
      : super(currentDuration: currentDuration);

  @override
  List<Object> get props => [currentDuration];
}

class TimerStop extends TimerState {
  const TimerStop(currentDuration) : super(currentDuration: currentDuration);

  @override
  List<Object> get props => [currentDuration];
}
