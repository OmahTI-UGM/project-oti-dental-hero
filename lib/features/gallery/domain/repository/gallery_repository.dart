import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/gallery/domain/entities/comparison_snapshot.dart';
import 'package:image_picker/image_picker.dart';

abstract class GalleryRepository {
  Future<DataState<ComparisonSnapshotEntity?>?> getComparisonSnapshot({
    required String userId,
  });

  Future<DataState<void>?> updateComparisonSnapshotImages({
    required String userId,
    required List<XFile> imageFiles,
    required SnapshotState snapshotState,
  });
}
