enum TimeState {
  day,
  night,
}

extension TimeStateExtension on TimeState {
  String get value {
    switch (this) {
      case TimeState.day:
        return 'day';
      case TimeState.night:
        return 'night';
      default:
        return 'unknown';
    }
  }
}
