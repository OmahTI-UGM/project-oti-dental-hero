import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/activity.dart';
import '../repository/activity_repository.dart';

class UpdateActivityUseCase
    implements UseCase<DataState<ActivityEntity?>?, UpdateActivityParams> {
  final ActivityRepository repository;

  const UpdateActivityUseCase({required this.repository});

  @override
  Future<DataState<ActivityEntity?>?> call(
      {UpdateActivityParams? params}) async {
    return await repository.updateActivity(
      userId: params!.userId,
      date: params.date,
      duration: params.duration,
      score: params.score,
      timeState: params.timeState,
    );
  }
}

class UpdateActivityParams extends Equatable {
  final String userId;
  final DateTime date;
  final int duration;
  final int score;
  final TimeState timeState;

  const UpdateActivityParams({
    required this.userId,
    required this.date,
    required this.duration,
    required this.score,
    required this.timeState,
  });

  @override
  List<Object?> get props => [
        userId,
        date,
        duration,
        score,
        timeState,
      ];
}
