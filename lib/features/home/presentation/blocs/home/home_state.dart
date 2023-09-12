import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final List<ActivityEntity>? activities;

  const HomeState({this.activities});

  @override
  List<Object?> get props => [activities];
}

class HomeLoading extends HomeState {
  const HomeLoading() : super();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({required List<ActivityEntity> activities})
      : super(activities: activities);
}

class HomeFailed extends HomeState {
  final FirebaseException? firebaseError;
  final Exception? error;

  const HomeFailed({this.firebaseError, this.error}) : super();

  String get message => firebaseError?.message ?? error?.toString() ?? "";
}

class HomeInitial extends HomeState {
  const HomeInitial() : super();
}
