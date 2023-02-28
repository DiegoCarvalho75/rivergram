import 'package:rivergram/state/image_upload/exception/could_not_build_thumbnail_exception.dart';
import 'package:rivergram/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file_type.dart';
import '../models/image_with_aspect_ratio.dart';
import '../models/thumbnail_request.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest request) async {
  final Image image;
  switch (request.fileType) {
    case FileType.image:
      image = Image.network(
        request.file.path,
        fit: BoxFit.fitHeight,
      );
      // image = Image.file(
      //   request.file,
      //   fit: BoxFit.fitHeight,
      // );
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw CouldNotBuildThumbnailException();
      } else {
        image = Image.memory(
          thumb,
          fit: BoxFit.fitHeight,
        );
      }
      break;
  }
  final aspectRatio = await image.getImageAspectRatio();
  return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
});
