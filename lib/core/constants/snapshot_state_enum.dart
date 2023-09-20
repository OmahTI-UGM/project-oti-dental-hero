enum SnapshotState {
  before,
  after,
}

extension TimeStateExtension on SnapshotState {
  String get value {
    switch (this) {
      case SnapshotState.before:
        return 'before';
      case SnapshotState.after:
        return 'after';
      default:
        return 'unknown';
    }
  }

  static SnapshotState fromString(String value) {
    switch (value) {
      case 'before':
        return SnapshotState.before;
      case 'after':
        return SnapshotState.after;
      default:
        return SnapshotState.before;
    }
  }
}
