import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/get_user_activities.dart';
import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';
import 'package:dental_hero/features/gallery/domain/usecases/get_comparison_snapshot.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_hero/features/home/presentation/blocs/home/home_events.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserActivitiesUseCase getUserActivitiesUseCase;
  final GetComparisonSnapshotUseCase getComparisonSnapshotUseCase;

  HomeBloc(this.getUserActivitiesUseCase, this.getComparisonSnapshotUseCase)
      : super(const HomeInitial()) {
    on<LoadDataEvent>(_onLoadActivities);
  }
  _onLoadActivities(LoadDataEvent event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    final userId = event.userId;
    final activityParams = GetUserActivitiesParams(userId: userId);
    final comparisonSnapshotParams =
        GetComparisonSnapshotParams(userId: userId);

    DataState<List<ActivityEntity>?> activityResult =
        await getUserActivitiesUseCase(params: activityParams);

    DataState<ComparisonSnapshotEntity?>? comparisonSnapshotResult =
        await getComparisonSnapshotUseCase(params: comparisonSnapshotParams);

    if (activityResult is DataSuccess &&
        activityResult.data != null &&
        comparisonSnapshotResult is DataSuccess) {
      final activities = activityResult.data!;
      final comparisonSnapshot = comparisonSnapshotResult!.data;

      Map<DateTime, List<ActivityEntity>> groupedData = {};
      for (var activity in activities) {
        var date = activity.date;

        if (!groupedData.containsKey(date)) {
          groupedData[date!] = [];
        }

        groupedData[date]!.add(activity);
      }

      emit(HomeSuccess(
        activities: activityResult.data!,
        activityGroups: groupedData,
        comparisonSnapshot: comparisonSnapshot!,
      ));
    }

    if (activityResult.data == null) {
      emit(const HomeLoading());
    }

    if (activityResult is DataFailed) {
      emit(HomeFailed(error: activityResult.error));
    }
  }
}
