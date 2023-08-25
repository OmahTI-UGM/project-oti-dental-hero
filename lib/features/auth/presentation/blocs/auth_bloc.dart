import 'package:bloc/bloc.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:dental_hero/features/auth/presentation/blocs/auth_event.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase)
      : super(const AuthLoading()) {
    on<LoginEvent>(onLogin);
  }

  void onLogin(LoginEvent event, Emitter<AuthState> emit) {
    // Unimplemented
  }

  void onRegister() {
    // Unimplemented
  }
}
