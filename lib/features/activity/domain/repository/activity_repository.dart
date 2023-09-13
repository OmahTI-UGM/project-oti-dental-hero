import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';

abstract class ActivityRepository {
  Future<DataState<ActivityEntity?>> saveActivity({
    required String userId,
    required DateTime date,
    required int duration,
    required int score,
    required TimeState timeState,
  });

  Future<DataState<List<ActivityEntity>?>> getUserActivities({
    required String userId,
  });

  Future<DataState<ActivityEntity?>> getActivity({
    required String userId,
    required DateTime date,
  });

  Future<DataState<void>> updateActivity({
    required String userId,
    required DateTime date,
    required int duration,
    required int score,
    required TimeState timeState,
  });

  Future<DataState<void>> createInitialActivities({
    required String userId,
    int days = 30,
  });
}
