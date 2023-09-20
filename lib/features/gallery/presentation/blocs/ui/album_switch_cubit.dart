import 'package:flutter_bloc/flutter_bloc.dart';

// Define the possible states for the StatisticSwitch
enum AlbumSwitchState { before, after }

// Create a Cubit class to manage the state
class AlbumSwitchCubit extends Cubit<AlbumSwitchState> {
  AlbumSwitchCubit() : super(AlbumSwitchState.before);

  // Add methods to change the state
  void switchToBefore() => emit(AlbumSwitchState.before);
  void switchToAfter() => emit(AlbumSwitchState.after);
}
