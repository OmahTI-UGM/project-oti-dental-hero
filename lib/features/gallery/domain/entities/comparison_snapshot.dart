import 'package:equatable/equatable.dart';

class ComparisonSnapshotEntity extends Equatable {
  final String? id;
  final DateTime? before;
  final DateTime? after;
  final List<String>? beforeImageUrls;
  final List<String>? afterImageUrls;

  const ComparisonSnapshotEntity({
    this.id,
    this.before,
    this.after,
    this.beforeImageUrls,
    this.afterImageUrls,
  });

  @override
  List<Object?> get props => [
        id,
        beforeImageUrls,
        afterImageUrls,
      ];

  @override
  String toString() {
    return ''' 
    ArDocumentEntity{
      id: $id,
      beforeImageUrls: $beforeImageUrls,
      afterImageUrls: $afterImageUrls,
    }
    ''';
  }
}
