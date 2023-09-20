import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/domain/usecases/get_leaderboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'leaderboard_state.dart';
import 'leaderboard_event.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase _getLeaderboardUseCase;

  LeaderboardBloc(this._getLeaderboardUseCase)
      : super(const LeaderboardInitial()) {
    on<FetchLeaderboardEvent>(onGetLeaderboard);
  }

  Future<void> onGetLeaderboard(
      FetchLeaderboardEvent event, Emitter<LeaderboardState> emit) async {
    try {
      emit(const LeaderboardLoading());
      final params =
          GetLeaderboardParams(limit: event.limit, offset: event.offset);

      final dataState = await _getLeaderboardUseCase(params: params);

      if (dataState is DataSuccess && dataState.data != null) {
        emit(LeaderboardSuccess(dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(LeaderboardFailed(
            error: Exception("Failed to get leaderboard. Try again.")));
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(const LeaderboardInitial());
      }
    } catch (e) {
      emit(LeaderboardFailed(
          error: Exception("Failed to get leaderboard. Try again.")));
    }
  }
}
