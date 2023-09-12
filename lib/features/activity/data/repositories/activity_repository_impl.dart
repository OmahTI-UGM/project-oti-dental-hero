import 'package:dental_hero/features/activity/data/data_sources/remote/activity_api_service.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/domain/repository/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityApiService _activityApiService;

  ActivityRepositoryImpl({required ActivityApiService activityApiService})
      : _activityApiService = activityApiService;

  @override
  Future<DataState<ActivityEntity?>> getActivity({
    required String userId,
    required DateTime date,
  }) async {
    try {
      ActivityEntity? activity = await _activityApiService.getActivity(
        userId: userId,
        date: date,
      );

      if (activity == null) {
        return DataFailed(error: Exception("Activity not found"));
      }

      return DataSuccess(data: activity);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<List<ActivityEntity>?>> getUserActivities(
      {required String userId}) async {
    try {
      List<ActivityEntity>? activities =
          await _activityApiService.getActivities(
        userId: userId,
      );
      return DataSuccess(data: activities);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<ActivityEntity?>> saveActivity({
    required String userId,
    required DateTime date,
    required int duration,
    required int score,
    required TimeState timeState,
  }) async {
    try {
      ActivityEntity? activity = await _activityApiService.saveActivity(
        userId: userId,
        date: date,
        duration: duration,
        score: score,
        timeState: timeState,
      );

      if (activity == null) {
        return DataFailed(error: Exception("Activity not found"));
      }

      return DataSuccess(data: activity);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }
}
