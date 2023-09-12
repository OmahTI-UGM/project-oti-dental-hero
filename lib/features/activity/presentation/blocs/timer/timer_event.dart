import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TimerEvent {
  final int duration;

  const StartTimer(this.duration);

  @override
  List<Object> get props => [duration];
}

class UpdateTimer extends TimerEvent {
  final int currentDuration;

  const UpdateTimer(this.currentDuration);

  @override
  List<Object> get props => [currentDuration];
}

class StopTimer extends TimerEvent {
  final int currentDuration;

  const StopTimer(this.currentDuration);

  @override
  List<Object> get props => [currentDuration];
}

class ResetTimer extends TimerEvent {
  @override
  List<Object> get props => [];
}
