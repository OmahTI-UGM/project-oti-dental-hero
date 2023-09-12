import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/activity.dart';
import '../repository/activity_repository.dart';

class GetUserActivitiesUseCase
    implements
        UseCase<DataState<List<ActivityEntity>?>, GetUserActivitiesParams> {
  final ActivityRepository repository;

  const GetUserActivitiesUseCase({required this.repository});

  @override
  Future<DataState<List<ActivityEntity>?>> call(
      {GetUserActivitiesParams? params}) async {
    return await repository.getUserActivities(userId: params!.userId);
  }
}

class GetUserActivitiesParams extends Equatable {
  final String userId;

  const GetUserActivitiesParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
