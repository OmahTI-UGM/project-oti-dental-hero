import 'package:dental_hero/core/resources/data_state.dart';
import 'package:dental_hero/features/gallery/domain/usecases/update_comparison_snapshot_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _imagePicker = ImagePicker();

  final UpdateComparisonSnapshotUseCase updateComparisonSnapshotUseCase;

  ImagePickerBloc(this.updateComparisonSnapshotUseCase)
      : super(InitialImagePickerState()) {
    on<InitializeImagePickerEvent>(_onInitializeImagePicker);
    on<PickImageEvent>(_onPickImage);
    on<DeleteImageEvent>(_onDeleteImage);
    on<StepChangeEvent>(_onStepChange);
    on<SubmitImageEvent>(_onSubmitImage);
  }

  void _onInitializeImagePicker(
      InitializeImagePickerEvent event, Emitter<ImagePickerState> emit) {
    emit(InitialImagePickerState(
        images: [], userId: event.userId, snapshotState: event.snapshotState));
  }

  void _onPickImage(
      PickImageEvent event, Emitter<ImagePickerState> emit) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      emit(ImagePickedState(
        state.images!,
        state.userId!,
        state.snapshotState!,
        image,
      ));
      print(state.images!.map((xFile) => xFile.path).toList());
      print(state.images!.length);
    }
  }

  void _onDeleteImage(DeleteImageEvent event, Emitter<ImagePickerState> emit) {
    // Remove the last image from the list of images
    final List<XFile> updatedImages = List.from(state.images!);
    if (updatedImages.isNotEmpty) {
      updatedImages.removeLast();
    }

    emit(ImageNewState(
      updatedImages,
      state.userId!,
      state.snapshotState!,
    ));
    print(updatedImages.map((xFile) => xFile.path).toList());
    print(updatedImages.length);
  }

  void _onStepChange(StepChangeEvent event, Emitter<ImagePickerState> emit) {
    emit(ImageNewState(state.images!, state.userId!, state.snapshotState!));
  }

  void _onSubmitImage(
      SubmitImageEvent event, Emitter<ImagePickerState> emit) async {
    // submit to firestore and storage
    final params = UpdateComparisonSnapshotParams(
      userId: state.userId!,
      imageFiles: state.images!,
      snapshotState: state.snapshotState!,
    );

    try {
      emit(LoadingImagePickerState());

      final dataState = await updateComparisonSnapshotUseCase(params: params);

      if (dataState is DataFailed) {
        emit(FailedImagePickerState());
      }
      emit(SuccessImagePickerState());
    } on Exception catch (e) {
      emit(FailedImagePickerState());
    }
  }
}
