import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';

class ComparisonSnapshotModel extends ComparisonSnapshotEntity {
  const ComparisonSnapshotModel({
    String? id,
    DateTime? before,
    DateTime? after,
    List<String>? beforeImageUrls,
    List<String>? afterImageUrls,
  }) : super(
          id: id,
          before: before,
          after: after,
          beforeImageUrls: beforeImageUrls,
          afterImageUrls: afterImageUrls,
        );

  factory ComparisonSnapshotModel.fromJson(Map<String, dynamic> map) {
    return ComparisonSnapshotModel(
      id: map['id'],
      before: map['before'],
      after: map['after'],
      beforeImageUrls: map['beforeImageUrls'],
      afterImageUrls: map['afterImageUrls'],
    );
  }

  factory ComparisonSnapshotModel.fromEntity(ComparisonSnapshotEntity entity) {
    return ComparisonSnapshotModel(
      id: entity.id,
      before: entity.before,
      after: entity.after,
      beforeImageUrls: entity.beforeImageUrls,
      afterImageUrls: entity.afterImageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'before': before,
      'after': after,
      'beforeImageUrls': beforeImageUrls,
      'afterImageUrls': afterImageUrls,
    };
  }

  @override
  List<Object?> get props => [
        id,
        beforeImageUrls,
        afterImageUrls,
      ];
}
