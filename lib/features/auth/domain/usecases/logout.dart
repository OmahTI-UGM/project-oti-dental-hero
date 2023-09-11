import 'package:dental_hero/core/usecase/usecase.dart';

import '../repository/auth_repository.dart';

class LogoutUseCase extends UseCase<bool, void> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<bool> call({void params}) async {
    return await repository.logout();
  }
}
