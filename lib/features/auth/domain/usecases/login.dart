import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/user.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  const LoginUseCase({required this.repository});

  @override
  Future<UserEntity> call({LoginParams? params}) async {
    return await repository.login(
      fullName: params!.fullName,
      birthDate: params.birthDate,
    );
  }
}

class LoginParams extends Equatable {
  final String fullName;
  final DateTime birthDate;

  const LoginParams({required this.fullName, required this.birthDate});

  @override
  List<Object?> get props => [fullName, birthDate];
}
