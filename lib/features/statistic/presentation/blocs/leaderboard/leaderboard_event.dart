abstract class LeaderboardEvent {
  const LeaderboardEvent();
}

class FetchLeaderboardEvent extends LeaderboardEvent {
  final int? limit;
  final String? offset;

  const FetchLeaderboardEvent({
    this.limit = 10,
    this.offset,
  });
}
