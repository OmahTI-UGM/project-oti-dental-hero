import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';
import 'package:equatable/equatable.dart';

abstract class StatisticState extends Equatable {
  final List<ActivityEntity>? activities;
  final Map<DateTime, List<ActivityEntity>>? activityGroups;

  const StatisticState({this.activities, this.activityGroups});

  @override
  List<Object?> get props => [];
}

class StatisticLoading extends StatisticState {
  const StatisticLoading() : super();
}

class StatisticSuccess extends StatisticState {
  const StatisticSuccess(List<ActivityEntity> activities,
      Map<DateTime, List<ActivityEntity>> activityGroups)
      : super(activities: activities, activityGroups: activityGroups);
}

class StatisticFailed extends StatisticState {
  final FirebaseException? firebaseError;
  final Exception? error;

  const StatisticFailed({this.firebaseError, this.error});

  String get message => firebaseError?.message ?? error?.toString() ?? "";
}

class StatisticInitial extends StatisticState {
  const StatisticInitial();
}
