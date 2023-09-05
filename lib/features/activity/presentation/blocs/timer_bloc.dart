import 'package:dental_hero/features/activity/presentation/blocs/timer_event.dart';
import 'package:dental_hero/features/activity/presentation/blocs/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>(onStartTimer);
    on<UpdateTimer>(onUpdateTimer);
    on<StopTimer>(onStopTimer);
  }
  void onStartTimer(event, emit) {
    print(event.duration);
    emit(TimerInProgress(event.duration));
  }

  void onUpdateTimer(event, emit) {
    print(event.currentDuration);
    emit(TimerInProgress(event.currentDuration));
    //if timer is finished
    if (event.currentDuration == 0) {
      emit(TimerStop(event.currentDuration));
    }
  }

  void onStopTimer(event, emit) {
    print(event.currentDuration);
    emit(TimerStop(event.currentDuration));
  }
}
