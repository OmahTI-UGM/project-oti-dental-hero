// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// // Events
// abstract class ImagePickerEvent {}

// class PickImageEvent extends ImagePickerEvent {}

// class DeleteImageEvent extends ImagePickerEvent {}

// class StepChangeEvent extends ImagePickerEvent {}

// // States
// abstract class ImagePickerState {
//   final List<XFile> images = [];
// }

// class InitialImagePickerState extends ImagePickerState {}

// class ImagePickedState extends ImagePickerState {
//   final XFile image;

//   ImagePickedState(this.image) : super() {
//     images.add(image);
//   }
// }

// class ImageNewState extends ImagePickerState {
//   ImageNewState() : super();
// }

// class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
//   final ImagePicker _imagePicker = ImagePicker();

//   ImagePickerBloc() : super(InitialImagePickerState()) {
//     on<PickImageEvent>(_onPickImage);
//     on<DeleteImageEvent>(_onDeleteImage);
//     on<StepChangeEvent>(_onStepChange);
//   }

//   void _onPickImage(
//       PickImageEvent event, Emitter<ImagePickerState> emit) async {
//     final XFile? image = await _imagePicker.pickImage(
//       source: ImageSource.camera,
//       preferredCameraDevice: CameraDevice.front,
//     );

//     if (image != null) {
//       emit(ImagePickedState(image));
//       print(state.images.map((xFile) => xFile.path).toList());
//     }
//   }

//   void _onDeleteImage(DeleteImageEvent event, Emitter<ImagePickerState> emit) {
//     // Remove the last image from the list of images
//     final List<XFile> updatedImages = List.from(state.images);
//     if (updatedImages.isNotEmpty) {
//       updatedImages.removeLast();
//     }

//     emit(InitialImagePickerState()..images.addAll(updatedImages));
//     print(state.images.map((xFile) => xFile.path).toList());
//   }
// }

// void _onStepChange(StepChangeEvent event, Emitter<ImagePickerState> emit) {
//   emit(ImageNewState());
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// Events
abstract class ImagePickerEvent {}

class PickImageEvent extends ImagePickerEvent {}

class DeleteImageEvent extends ImagePickerEvent {}

class StepChangeEvent extends ImagePickerEvent {}

// States
abstract class ImagePickerState {
  final List<XFile> images;

  ImagePickerState(this.images);
}

class InitialImagePickerState extends ImagePickerState {
  InitialImagePickerState(List<XFile> images) : super(images);
}

class ImagePickedState extends ImagePickerState {
  final XFile image;

  ImagePickedState(List<XFile> currentImages, this.image)
      : super(List.from(currentImages)..add(image));
}

class ImageNewState extends ImagePickerState {
  ImageNewState(List<XFile> images) : super(images);
}

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
