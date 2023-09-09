import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase)
      : super(const AuthLoading()) {
    on<LoginEvent>(onLogin);

    on<RegisterEvent>(onRegister);
  }

  Future<void> onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      final params = LoginParams(
        fullName: event.fullName,
        birthDate: event.birthDate,
      );

      final DataState<UserEntity>? dataState =
          await _loginUseCase(params: params);

      if (dataState is DataSuccess && dataState!.data != null) {
        emit(AuthSuccess(user: dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(AuthFailed(error: Exception("Failed to login. Try again.")));
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(const AuthInitial());
      }
    } catch (e) {
      print(e);
      emit(AuthFailed(error: Exception("Failed to login. Try again.")));
    }
  }

  Future<void> onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    final params = RegisterParams(
      fullName: event.fullName,
      birthDate: event.birthDate,
      email: event.email,
      disability: event.disability,
    );

    final dataState = await _registerUseCase(params: params);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(AuthSuccess(user: dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(AuthFailed(error: dataState.error!));
    }
  }
}
