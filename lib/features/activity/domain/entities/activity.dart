import 'package:dental_hero/core/constants/time_state_enum.dart';
import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final String? id;
  final String? userId;
  final DateTime? date;
  final int? duration;
  final int? score;
  final TimeState? timeState;

  const ActivityEntity({
    this.id,
    this.userId,
    this.date,
    this.duration,
    this.score,
    this.timeState,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        duration,
        score,
        timeState,
      ];

  @override
  String toString() {
    return 'ActivityEntity{id: $id, userId: $userId, date: $date, duration: $duration, score: $score, timeState: $timeState}';
  }
}
