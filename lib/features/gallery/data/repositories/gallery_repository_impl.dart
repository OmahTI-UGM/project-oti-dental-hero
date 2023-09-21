import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';
import 'package:dental_hero/features/gallery/domain/repository/gallery_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../data_sources/remote/gallery_api_service.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryApiService _galleryApiService;

  GalleryRepositoryImpl({required GalleryApiService galleryApiService})
      : _galleryApiService = galleryApiService;

  @override
  Future<DataState<ComparisonSnapshotEntity?>?> getComparisonSnapshot({
    required String userId,
  }) async {
    try {
      ComparisonSnapshotEntity? comparisonSnapshot =
          await _galleryApiService.getComparisonSnapshot(
        userId: userId,
      );

      return DataSuccess(data: comparisonSnapshot);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<void>?> updateComparisonSnapshotImages(
      {required String userId,
      required List<XFile> imageFiles,
      required SnapshotState snapshotState}) async {
    try {
      final List<String> imageUrls =
          await _galleryApiService.uploadComparisonSnapshotImages(
        userId: userId,
        images: imageFiles,
      );

      await _galleryApiService.updateComparisonSnapshotImages(
        userId: userId,
        imageUrls: imageUrls,
        snapshotState: snapshotState,
      );

      return const DataSuccess(
        data: null,
      );
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }

  @override
  Future<DataState<void>?> createInitialComparisonSnapshot({
    required String userId,
    int days = 30,
  }) async {
    try {
      await _galleryApiService.createInitialComparisonSnapshot(
          userId: userId, days: days);

      return const DataSuccess(data: null);
    } on Exception catch (e) {
      return DataFailed(error: e);
    }
  }
}
