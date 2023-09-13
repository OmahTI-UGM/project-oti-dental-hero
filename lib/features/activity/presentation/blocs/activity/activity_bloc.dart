import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/usecases/save_activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/update_activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final SaveActivityUseCase saveActivityUseCase;
  final UpdateActivityUseCase updateActivityUseCase;
  ActivityBloc(
      {required this.saveActivityUseCase, required this.updateActivityUseCase})
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

      if (dataState is DataSuccess) {
        emit(ActivitySuccess(activity: dataState.data));
      }
      if (dataState is DataFailed) {
        emit(ActivityFailed(error: dataState.error!));
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
