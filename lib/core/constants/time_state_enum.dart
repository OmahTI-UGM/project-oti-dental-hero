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

  static TimeState fromString(String value) {
    switch (value) {
      case 'day':
        return TimeState.day;
      case 'night':
        return TimeState.night;
      default:
        return TimeState.day;
    }
  }
}
