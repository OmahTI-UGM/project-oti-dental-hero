import 'package:dental_hero/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String fullName,
    required DateTime birthDate,
    required String email,
    String disability,
  });

  Future<UserEntity> login({
    required String fullName,
    required DateTime birthDate,
  });
}
