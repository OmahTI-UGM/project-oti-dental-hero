import 'package:dental_hero/core/usecase/sync_usecase.dart';
import 'package:dental_hero/features/auth/domain/repository/auth_repository.dart';

import '../entities/user.dart';

class CheckAuthUseCase extends SyncUseCase<UserEntity?, void> {
  AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  @override
  UserEntity? call({void params}) {
    return repository.checkAuth();
  }
}
