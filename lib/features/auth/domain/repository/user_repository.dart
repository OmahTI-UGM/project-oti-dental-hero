import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<void>> incrementScore({
    required int score,
    required String userId,
  });

  Future<DataState<List<UserEntity>?>> getLeaderboard({
    int? limit,
    String? offset,
  });
}
