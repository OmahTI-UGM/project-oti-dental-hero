import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/core/usecase/usecase.dart';
import 'package:dental_hero/features/gallery/domain/repository/gallery_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UpdateComparisonSnapshotUseCase
    implements UseCase<DataState<void>?, UpdateComparisonSnapshotParams> {
  final GalleryRepository repository;

  const UpdateComparisonSnapshotUseCase({required this.repository});

  @override
  Future<DataState<void>?> call(
      {UpdateComparisonSnapshotParams? params}) async {
    return await repository.updateComparisonSnapshotImages(
      userId: params!.userId,
      imageFiles: params.imageFiles,
      snapshotState: params.snapshotState,
    );
  }
}

class UpdateComparisonSnapshotParams extends Equatable {
  final String userId;
  final List<XFile> imageFiles;
  final SnapshotState snapshotState;

  const UpdateComparisonSnapshotParams({
    required this.userId,
    required this.imageFiles,
    required this.snapshotState,
  });

  @override
  List<Object?> get props => [
        userId,
        imageFiles,
        snapshotState,
      ];
}
