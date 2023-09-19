// --- BLoC ---

// Events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConfettiEvent {}

class ShowConfetti extends ConfettiEvent {}

// States
abstract class ConfettiState {}

class ConfettiInitial extends ConfettiState {}

class ConfettiPlaying extends ConfettiState {}

class ConfettiBloc extends Bloc<ConfettiEvent, ConfettiState> {
  ConfettiBloc() : super(ConfettiInitial());

  @override
  Stream<ConfettiState> mapEventToState(ConfettiEvent event) async* {
    if (event is ShowConfetti) {
      yield ConfettiPlaying();
    }
  }
}
