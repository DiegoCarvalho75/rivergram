import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rivergram/state/image_upload/extensions/to_file.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() {
    return _imagePicker.pickImage(source: ImageSource.gallery).toFile();
  }

  static Future<File?> pickVideoFromGallery() {
    return _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
  }
}
