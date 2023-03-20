import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<XFile?> pickImageFromGallery() {
    return _imagePicker.pickImage(source: ImageSource.gallery);
    // .toFile();
  }

  static Future<XFile?> pickVideoFromGallery() {
    return _imagePicker.pickVideo(source: ImageSource.gallery);
    // .toFile();
  }
}
