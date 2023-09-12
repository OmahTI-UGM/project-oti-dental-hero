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
      timeState: map['timeState'] != null
          ? TimeStateExtension.fromString(map['timeState'])
          : null,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'duration': duration,
      'score': score,
      'timeState': timeState?.value,
    };
  }

  String toJson() => '''
  {
    "id": "$id",
    "userId": "$userId",
    "date": "$date",
    "duration": $duration,
    "score": $score,
    "timeState": "${timeState?.value}"
  }
  ''';
}
