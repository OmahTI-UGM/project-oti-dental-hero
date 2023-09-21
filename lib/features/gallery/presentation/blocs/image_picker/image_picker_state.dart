import 'package:dental_hero/core/constants/snapshot_state_enum.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState {
  final List<XFile>? images;
  final String? userId;
  final SnapshotState? snapshotState;

  ImagePickerState({this.images, this.userId, this.snapshotState});
}

class InitialImagePickerState extends ImagePickerState {
  InitialImagePickerState({
    List<XFile>? images,
    String? userId,
    SnapshotState? snapshotState,
  }) : super(
          images: images,
          userId: userId,
          snapshotState: snapshotState,
        );
}

class ImagePickedState extends ImagePickerState {
  final XFile image;

  ImagePickedState(
    List<XFile> currentImages,
    String userId,
    SnapshotState snapshotState,
    this.image,
  ) : super(
          images: List.from(currentImages)..add(image),
          userId: userId,
          snapshotState: snapshotState,
        );
}

class ImageNewState extends ImagePickerState {
  ImageNewState(List<XFile> images, String userId, SnapshotState snapshotState)
      : super(
          images: images,
          userId: userId,
          snapshotState: snapshotState,
        );
}

class LoadingImagePickerState extends ImagePickerState {}

class SuccessImagePickerState extends ImagePickerState {}

class FailedImagePickerState extends ImagePickerState {}
