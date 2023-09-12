import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:dental_hero/features/activity/domain/entities/activity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    String? id,
    String? userId,
    DateTime? date,
    int? duration,
    int? score,
    TimeState? timeState,
  }) : super(
          id: id,
          userId: userId,
          date: date,
          duration: duration,
          score: score,
          timeState: timeState,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      userId: map['userId'],
      date: map['date'].toDate(),
      duration: map['duration'],
      score: map['score'],
      timeState: TimeStateExtension.fromString(map['timeState']),
    );
  }

  factory ActivityModel.fromEntity(ActivityEntity entity) {
    return ActivityModel(
      id: entity.id,
      userId: entity.userId,
      date: entity.date,
      duration: entity.duration,
      score: entity.score,
      timeState: entity.timeState,
    );
  }
}
