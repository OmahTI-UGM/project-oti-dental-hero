import 'package:dental_hero/core/constants/snapshot_state_enum.dart';

abstract class ImagePickerEvent {}

class InitializeImagePickerEvent extends ImagePickerEvent {
  final String userId;
  final SnapshotState snapshotState;

  InitializeImagePickerEvent({
    required this.userId,
    required this.snapshotState,
  });
}

class PickImageEvent extends ImagePickerEvent {}

class DeleteImageEvent extends ImagePickerEvent {}

class StepChangeEvent extends ImagePickerEvent {}

class SubmitImageEvent extends ImagePickerEvent {}
