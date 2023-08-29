import 'package:cloud_firestore/cloud_firestore.dart';
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

class AuthSuccess extends AuthState {
  const AuthSuccess({required UserEntity user}) : super(user: user);
}

class AuthFailed extends AuthState {
  final FirebaseException? firebaseError;
  final Exception? error;

  const AuthFailed({this.firebaseError, this.error}) : super();

  String get message => firebaseError?.message ?? error?.toString() ?? "";
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}
