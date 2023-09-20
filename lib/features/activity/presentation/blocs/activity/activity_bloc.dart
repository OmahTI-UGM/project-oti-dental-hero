import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/usecases/save_activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/update_activity.dart';
import 'package:dental_hero/features/auth/domain/usecases/increment_score.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final SaveActivityUseCase saveActivityUseCase;
  final UpdateActivityUseCase updateActivityUseCase;
  final IncrementScoreUseCase incrementScoreUseCase;

  ActivityBloc(
      {required this.saveActivityUseCase,
      required this.updateActivityUseCase,
      required this.incrementScoreUseCase})
      : super(const ActivityInitial()) {
    on<SaveActivityEvent>(onSaveActivity);
    on<ResetActivityEvent>(onResetActivity);
  }

  Future<void> onSaveActivity(
      SaveActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      emit(const ActivityLoading());
      // final dataState = await saveActivityUseCase(
      //     params: SaveActivityParams.fromActivityEntity(event.activity));

      final dataState = await updateActivityUseCase(
          params: UpdateActivityParams.fromActivityEntity(event.activity));

      // update user score
      final dataStateUser = await incrementScoreUseCase(
          params: IncrementScoreParams(
              score: event.activity.score!, userId: event.activity.userId!));

      if (dataState is DataSuccess && dataStateUser is DataSuccess) {
        emit(ActivitySuccess(activity: dataState.data));
      }
      if (dataState is DataFailed || dataStateUser is DataFailed) {
        emit(ActivityFailed(error: dataState!.error!));
      }
    } catch (e) {
      emit(ActivityFailed(error: Exception("Failed to save activity.")));
    }
  }

  Future<void> onResetActivity(
      ResetActivityEvent event, Emitter<ActivityState> emit) async {
    emit(const ActivityInitial());
  }
}
