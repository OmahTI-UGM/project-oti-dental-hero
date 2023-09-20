import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _imagePicker = ImagePicker();

  ImagePickerBloc() : super(InitialImagePickerState([])) {
    on<PickImageEvent>(_onPickImage);
    on<DeleteImageEvent>(_onDeleteImage);
    on<StepChangeEvent>(_onStepChange);
  }

  void _onPickImage(
      PickImageEvent event, Emitter<ImagePickerState> emit) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      emit(ImagePickedState(state.images, image));
      print(state.images.map((xFile) => xFile.path).toList());
      print(state.images.length);
    }
  }

  void _onDeleteImage(DeleteImageEvent event, Emitter<ImagePickerState> emit) {
    // Remove the last image from the list of images
    final List<XFile> updatedImages = List.from(state.images);
    if (updatedImages.isNotEmpty) {
      updatedImages.removeLast();
    }

    emit(ImageNewState(updatedImages));
    print(updatedImages.map((xFile) => xFile.path).toList());
    print(updatedImages.length);
  }

  void _onStepChange(StepChangeEvent event, Emitter<ImagePickerState> emit) {
    emit(ImageNewState(state.images));
  }
}
