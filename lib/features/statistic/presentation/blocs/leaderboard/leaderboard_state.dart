import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class LeaderboardState extends Equatable {
  final List<UserEntity>? leaderboard;

  const LeaderboardState({this.leaderboard});

  @override
  List<Object?> get props => [];
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading() : super();
}

class LeaderboardSuccess extends LeaderboardState {
  const LeaderboardSuccess(List<UserEntity> leaderboard)
      : super(leaderboard: leaderboard);
}

class LeaderboardFailed extends LeaderboardState {
  final FirebaseException? firebaseError;
  final Exception? error;

  const LeaderboardFailed({this.firebaseError, this.error});

  String get message => firebaseError?.message ?? error?.toString() ?? "";
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}
