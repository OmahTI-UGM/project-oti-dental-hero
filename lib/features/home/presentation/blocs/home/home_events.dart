abstract class HomeEvent {
  const HomeEvent();
}

class LoadDataEvent extends HomeEvent {
  final String userId;
  const LoadDataEvent({required this.userId});
}
