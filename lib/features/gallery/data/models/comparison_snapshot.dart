import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';

class ComparisonSnapshotModel extends ComparisonSnapshotEntity {
  const ComparisonSnapshotModel({
    String? id,
    List<String>? beforeImageUrls,
    List<String>? afterImageUrls,
  }) : super(
          id: id,
          beforeImageUrls: beforeImageUrls,
          afterImageUrls: afterImageUrls,
        );

  factory ComparisonSnapshotModel.fromJson(Map<String, dynamic> map) {
    return ComparisonSnapshotModel(
      id: map['id'],
      beforeImageUrls: map['beforeImageUrls'],
      afterImageUrls: map['afterImageUrls'],
    );
  }

  factory ComparisonSnapshotModel.fromEntity(ComparisonSnapshotEntity entity) {
    return ComparisonSnapshotModel(
      id: entity.id,
      beforeImageUrls: entity.beforeImageUrls,
      afterImageUrls: entity.afterImageUrls,
    );
  }

  @override
  List<Object?> get props => [
        id,
        beforeImageUrls,
        afterImageUrls,
      ];
}
