import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerInProgress extends TimerState {
  final int currentDuration;

  TimerInProgress(this.currentDuration);

  @override
  List<Object> get props => [currentDuration];
}

class CountdownCompleted extends TimerState {}
