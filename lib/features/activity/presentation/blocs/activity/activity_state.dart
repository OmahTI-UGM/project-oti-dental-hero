import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:equatable/equatable.dart';

abstract class ActivityState extends Equatable {
  final ActivityEntity? activity;

  const ActivityState({this.activity});

  @override
  List<Object?> get props => [activity];
}

class ActivityLoading extends ActivityState {
  const ActivityLoading() : super();
}

class ActivitySuccess extends ActivityState {
  const ActivitySuccess({required ActivityEntity activity})
      : super(activity: activity);
}

class ActivityFailed extends ActivityState {
  final FirebaseException? firebaseError;
  final Exception? error;

  const ActivityFailed({this.firebaseError, this.error}) : super();

  String get message => firebaseError?.message ?? error?.toString() ?? "";
}

class ActivityInitial extends ActivityState {
  const ActivityInitial() : super(activity: null);
}
