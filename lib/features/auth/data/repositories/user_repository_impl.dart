import 'package:dental_hero/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:dental_hero/features/auth/data/models/user.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl({required UserApiService userApiService})
      : _userApiService = userApiService;

  @override
  Future<DataState<List<UserEntity>?>> getLeaderboard({
    int? limit,
    String? offset,
  }) async {
    try {
      final List<UserModel> userModels = await _userApiService.getLeaderboard(
        limit: limit,
        offset: offset,
      );

      final List<UserEntity> userEntities = userModels.map((e) {
        return UserEntity(
          id: e.id,
          fullName: e.fullName,
          birthDate: e.birthDate,
          email: e.email,
          disability: e.disability,
          score: e.score,
        );
      }).toList();

      return DataSuccess(data: userEntities);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<void>> incrementScore({
    required int score,
    required String userId,
  }) async {
    try {
      await _userApiService.incrementScore(
        score: score,
        userId: userId,
      );

      return const DataSuccess(data: null);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }
}
