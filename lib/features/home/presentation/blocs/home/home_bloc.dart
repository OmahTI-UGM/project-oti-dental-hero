import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:dental_hero/features/activity/domain/usecases/get_user_activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_hero/features/home/presentation/blocs/home/home_events.dart';
import 'package:dental_hero/features/home/presentation/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserActivitiesUseCase getUserActivitiesUseCase;

  HomeBloc(this.getUserActivitiesUseCase) : super(const HomeInitial()) {
    on<LoadActivitiesEvent>(_onLoadActivities);
  }
  _onLoadActivities(LoadActivitiesEvent event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    final userId = event.userId;
    final params = GetUserActivitiesParams(userId: userId);

    DataState<List<ActivityEntity>?> result =
        await getUserActivitiesUseCase(params: params);

    if (result is DataSuccess) {
      emit(HomeSuccess(activities: result.data!));
    }

    if (result is DataFailed) {
      emit(HomeFailed(error: result.error));
    }
  }
}
