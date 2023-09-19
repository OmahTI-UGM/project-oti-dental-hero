import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/get_user_activities.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_event.dart';
import 'package:dental_hero/features/statistic/presentation/blocs/statistic/statistic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final GetUserActivitiesUseCase _getUserActivitiesUseCase;

  StatisticBloc(this._getUserActivitiesUseCase)
      : super(const StatisticInitial()) {
    on<FetchStatisticEvent>(onGetStatisticEvent);
  }

  Future<void> onGetStatisticEvent(
      FetchStatisticEvent event, Emitter<StatisticState> emit) async {
    try {
      emit(const StatisticLoading());
      final params = GetUserActivitiesParams(userId: event.userId);

      final dataState = await _getUserActivitiesUseCase(params: params);

      if (dataState is DataSuccess && dataState.data != null) {
        final activities = dataState.data!;

        Map<DateTime, List<ActivityEntity>> groupedData = {};
        for (var activity in activities) {
          var date = activity.date;

          if (!groupedData.containsKey(date)) {
            groupedData[date!] = [];
          }

          groupedData[date]!.add(activity);
        }
        emit(StatisticSuccess(activities, groupedData));
      }

      if (dataState is DataFailed) {
        emit(StatisticFailed(
            error: Exception("Failed to get statistic. Try again.")));
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(const StatisticInitial());
      }
    } catch (e) {
      emit(StatisticFailed(
          error: Exception("Failed to get statistic. Try again.")));
    }
  }
}
