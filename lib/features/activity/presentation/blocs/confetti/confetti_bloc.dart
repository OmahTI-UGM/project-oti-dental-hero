import 'package:flutter_bloc/flutter_bloc.dart';

enum ConfettiState { initial, active }

class ConfettiCubit extends Cubit<ConfettiState> {
  ConfettiCubit() : super(ConfettiState.active);

  void activateConfetti() {
    emit(ConfettiState.active);
  }
}
