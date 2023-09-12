import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/activity.dart';
import '../repository/activity_repository.dart';

class SaveActivityUseCase
    implements UseCase<DataState<ActivityEntity?>, SaveActivityParams> {
  final ActivityRepository repository;

  const SaveActivityUseCase({required this.repository});

  @override
  Future<DataState<ActivityEntity?>> call({SaveActivityParams? params}) async {
    return await repository.saveActivity(
      userId: params!.userId,
      date: params.date,
      duration: params.duration,
      score: params.score,
      timeState: params.timeState,
    );
  }
}

class SaveActivityParams extends Equatable {
  final String userId;
  final DateTime date;
  final int duration;
  final int score;
  final TimeState timeState;

  const SaveActivityParams({
    required this.userId,
    required this.date,
    required this.duration,
    required this.score,
    required this.timeState,
  });

  factory SaveActivityParams.fromActivityEntity(ActivityEntity activity) {
    return SaveActivityParams(
      userId: activity.userId!,
      date: activity.date!,
      duration: activity.duration!,
      score: activity.score!,
      timeState: activity.timeState!,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        date,
        duration,
        score,
        timeState,
      ];
}
