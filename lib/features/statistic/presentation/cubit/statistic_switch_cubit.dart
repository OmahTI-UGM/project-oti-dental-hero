import 'package:flutter_bloc/flutter_bloc.dart';

// Define the possible states for the StatisticSwitch
enum StatisticSwitchState { rank, statistik }

// Create a Cubit class to manage the state
class StatisticSwitchCubit extends Cubit<StatisticSwitchState> {
  StatisticSwitchCubit() : super(StatisticSwitchState.rank);

  // Add methods to change the state
  void switchToRank() => emit(StatisticSwitchState.rank);
  void switchToStatistik() => emit(StatisticSwitchState.statistik);
}
