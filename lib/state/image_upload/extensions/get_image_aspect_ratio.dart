import 'dart:async';

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageAspectRatio on material.Image {
  Future<double> getImageAspectRatio() async {
    final completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (
          imageInfo,
          synchronousCall,
        ) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.width;
          imageInfo.image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}
