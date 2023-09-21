import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/activity/domain/usecases/create_initial_activities.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:dental_hero/features/auth/domain/usecases/check_auth.dart';
import 'package:dental_hero/features/auth/domain/usecases/login.dart';
import 'package:dental_hero/features/auth/domain/usecases/logout.dart';
import 'package:dental_hero/features/auth/domain/usecases/register.dart';
import 'package:dental_hero/features/gallery/domain/usecases/create_initial_comparison_snapshot.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final CheckAuthUseCase _checkAuthUseCase;
  final LogoutUseCase _logoutUseCase;
  final CreateInitialActivitiesUseCase _createInitialActivitiesUseCase;
  final CreateInitialComparisonSnapshotUseCase
      _createInitialComparisonSnapshotUseCase;

  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._checkAuthUseCase,
    this._logoutUseCase,
    this._createInitialActivitiesUseCase,
    this._createInitialComparisonSnapshotUseCase,
  ) : super(const AuthInitial()) {
    on<LoginEvent>(onLogin);
    on<RegisterEvent>(onRegister);
    on<LogoutEvent>(onLogout);
    on<CheckAuthEvent>(onCheckAuth);
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
      await _createInitialActivitiesUseCase(
          params: CreateInitialActivitiesParams(
        userId: dataState.data!.id!,
        days: 30,
      ));

      // create initial comparison snapshot
      await _createInitialComparisonSnapshotUseCase(
          params: CreateInitialComparisonSnapshotParams(
              userId: dataState.data!.id!, days: 30));
    }

    if (dataState is DataFailed) {
      emit(AuthFailed(error: dataState.error!));
    }
  }

  void onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) {
    final user = _checkAuthUseCase();

    if (user != null) {
      emit(AuthSuccess(user: user));
    } else {
      emit(const AuthFailed());
    }
  }

  Future<void> onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    final dataState = await _logoutUseCase();

    if (dataState) {
      emit(const AuthInitial());
    }
  }
}
