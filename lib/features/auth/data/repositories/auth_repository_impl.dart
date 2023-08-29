import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl({required AuthApiService authApiService})
      : _authApiService = authApiService;

  @override
  Future<DataState<UserEntity>> login({
    String? fullName,
    DateTime? birthDate,
  }) async {
    try {
      UserEntity? user = await _authApiService.login(
        fullName: fullName,
        birthDate: birthDate,
      );

      if (user == null) {
        return DataFailed(error: Exception("User not found"));
      }

      return DataSuccess(data: user);
    } on FirebaseException catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<UserEntity>> register({
    required String fullName,
    required DateTime birthDate,
    required String email,
    String? disability,
  }) async {
    try {
      UserEntity user = await _authApiService.register(
        fullName: fullName,
        birthDate: birthDate,
        email: email,
        disability: disability,
      );

      return DataSuccess(data: user);
    } on FirebaseException catch (e) {
      return DataFailed(error: e);
    }
  }
}
