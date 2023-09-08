import 'package:dental_hero/features/activity/domain/entities/activity.dart';

abstract class ActivityEvent {
  const ActivityEvent();
}

class SaveActivityEvent extends ActivityEvent {
  final ActivityEntity activity;
  const SaveActivityEvent({
    required this.activity,
  });
}

class ResetActivityEvent extends ActivityEvent {
  const ResetActivityEvent();
}
