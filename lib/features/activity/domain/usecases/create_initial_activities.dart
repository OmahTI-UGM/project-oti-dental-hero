import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../repository/activity_repository.dart';

class CreateInitialActivitiesUseCase
    implements UseCase<DataState<void>, CreateInitialActivitiesParams> {
  final ActivityRepository repository;

  const CreateInitialActivitiesUseCase({required this.repository});

  @override
  Future<DataState<void>> call({CreateInitialActivitiesParams? params}) async {
    return await repository.createInitialActivities(
        userId: params!.userId, days: params.days);
  }
}

class CreateInitialActivitiesParams extends Equatable {
  final String userId;
  final int days;

  const CreateInitialActivitiesParams({
    required this.userId,
    required this.days,
  });

  @override
  List<Object?> get props => [
        userId,
        days,
      ];
}
