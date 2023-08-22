import 'package:dental_hero/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> register(
      {String fullName, DateTime birthDate, String email, String disability});

  Future<UserEntity> login({String fullName, DateTime birthDate});
}
