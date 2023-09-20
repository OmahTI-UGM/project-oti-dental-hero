import 'package:image_picker/image_picker.dart';

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
