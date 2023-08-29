import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TimerEvent {
  final int duration;

  StartTimer(this.duration);

  @override
  List<Object> get props => [duration];
}

class UpdateTimer extends TimerEvent {
  final int currentDuration;

  UpdateTimer(this.currentDuration);

  @override
  List<Object> get props => [currentDuration];
}
