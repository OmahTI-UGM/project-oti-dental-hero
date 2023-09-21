import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/gallery/domain/repository/gallery_repository.dart';
import 'package:equatable/equatable.dart';

class CreateInitialComparisonSnapshotUseCase
    implements
        UseCase<DataState<void>?, CreateInitialComparisonSnapshotParams> {
  final GalleryRepository repository;

  const CreateInitialComparisonSnapshotUseCase({required this.repository});

  @override
  Future<DataState<void>?> call(
      {CreateInitialComparisonSnapshotParams? params}) async {
    return await repository.createInitialComparisonSnapshot(
      userId: params!.userId,
      days: params.days,
    );
  }
}

class CreateInitialComparisonSnapshotParams extends Equatable {
  final String userId;
  final int days;

  const CreateInitialComparisonSnapshotParams({
    required this.userId,
    this.days = 30,
  });

  @override
  List<Object?> get props => [
        userId,
        days,
      ];
}
