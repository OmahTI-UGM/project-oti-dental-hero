import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final UserEntity? user;

  const AuthState({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLoading extends AuthState {
  const AuthLoading() : super();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required UserEntity user}) : super(user: user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated() : super();
}
