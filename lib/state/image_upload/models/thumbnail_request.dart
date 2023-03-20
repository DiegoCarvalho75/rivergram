import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'file_type.dart';

@immutable
class ThumbnailRequest {
  final XFile file;
  final FileType fileType;
  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThumbnailRequest &&
        other.file == file &&
        other.fileType == fileType;
  }

  @override
  // int get hashCode => file.hashCode ^ fileType.hashCode;
  int get hashCode => Object.hashAll([
        runtimeType,
        file,
        fileType,
      ]);
}
