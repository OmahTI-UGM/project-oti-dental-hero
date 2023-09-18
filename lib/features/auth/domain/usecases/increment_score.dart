import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/auth/domain/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

class IncrementScoreUseCase
    implements UseCase<DataState<void>, IncrementScoreParams> {
  final UserRepository repository;

  const IncrementScoreUseCase({required this.repository});

  @override
  Future<DataState<void>> call({IncrementScoreParams? params}) async {
    return await repository.incrementScore(
      score: params!.score,
      userId: params.userId,
    );
  }
}

class IncrementScoreParams extends Equatable {
  final int score;
  final String userId;

  const IncrementScoreParams({required this.score, required this.userId});

  @override
  List<Object?> get props => [score, userId];
}
