import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';
import 'package:dental_hero/features/gallery/domain/repository/gallery_repository.dart';
import 'package:equatable/equatable.dart';

class GetComparisonSnapshotUseCase
    implements
        UseCase<DataState<ComparisonSnapshotEntity?>?,
            GetComparisonSnapshotParams> {
  final GalleryRepository repository;

  const GetComparisonSnapshotUseCase({required this.repository});

  @override
  Future<DataState<ComparisonSnapshotEntity?>?> call(
      {GetComparisonSnapshotParams? params}) async {
    return await repository.getComparisonSnapshot(
      userId: params!.userId,
    );
  }
}

class GetComparisonSnapshotParams extends Equatable {
  final String userId;

  const GetComparisonSnapshotParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
