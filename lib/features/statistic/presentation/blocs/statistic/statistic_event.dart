abstract class StatisticEvent {
  const StatisticEvent();
}

class FetchStatisticEvent extends StatisticEvent {
  final String userId;

  const FetchStatisticEvent({required this.userId});
}
