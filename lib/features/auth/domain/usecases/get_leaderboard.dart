import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/auth/domain/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

import '../entities/user.dart';

class GetLeaderboardUseCase
    implements UseCase<DataState<List<UserEntity>?>, GetLeaderboardParams> {
  final UserRepository repository;

  const GetLeaderboardUseCase({required this.repository});

  @override
  Future<DataState<List<UserEntity>?>> call(
      {GetLeaderboardParams? params}) async {
    return await repository.getLeaderboard(
      limit: params!.limit,
      offset: params.offset,
    );
  }
}

class GetLeaderboardParams extends Equatable {
  final int? limit;
  final String? offset;

  const GetLeaderboardParams({this.limit = 10, this.offset});

  @override
  List<Object?> get props => [limit, offset];
}
