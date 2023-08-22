import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

import '../repository/auth_repository.dart';

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<UserEntity> call({RegisterParams? params}) async {
    return await repository.register(
      fullName: params!.fullName,
      birthDate: params.birthDate,
      email: params.email,
      disability: params.disability,
    );
  }
}

class RegisterParams extends Equatable {
  final String fullName;
  final DateTime birthDate;
  final String email;
  final String disability;

  const RegisterParams(
      {required this.fullName,
      required this.birthDate,
      required this.email,
      required this.disability});

  @override
  List<Object?> get props => [fullName, birthDate, email, disability];
}
