import 'package:dental_hero/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl({required AuthApiService authApiService})
      : _authApiService = authApiService;

  @override
  Future<UserEntity> login({
    String? fullName,
    DateTime? birthDate,
  }) async {
    UserEntity user = await _authApiService.login(
      fullName: fullName,
      birthDate: birthDate,
    );

    return user;
  }

  @override
  Future<UserEntity> register({
    required String fullName,
    required DateTime birthDate,
    required String email,
    String? disability,
  }) async =>
      await _authApiService.register(
        fullName: fullName,
        birthDate: birthDate,
        email: email,
        disability: disability,
      );
}
