import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> register({
    required String fullName,
    required DateTime birthDate,
    required String email,
    String? disability,
  });

  Future<DataState<UserEntity>> login({
    required String fullName,
    required DateTime birthDate,
  });
}
