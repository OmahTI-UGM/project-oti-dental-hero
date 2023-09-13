abstract class HomeEvent {
  const HomeEvent();
}

class LoadActivitiesEvent extends HomeEvent {
  final String userId;
  const LoadActivitiesEvent({required this.userId});
}
