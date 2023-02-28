import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getImageDataAspectRatio() async {
    final image = Image.memory(this);
    return image.getImageAspectRatio();
  }
}
