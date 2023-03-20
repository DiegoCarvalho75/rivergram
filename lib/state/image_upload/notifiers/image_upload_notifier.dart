// import 'package:image_picker';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as image_package;
import 'package:image_picker/image_picker.dart';
import 'package:rivergram/state/posts/models/post_payload.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../constants/firebase_collection_names.dart';
import '../../post_settings/models/post_settings.dart';
import '../../posts/typedefs/user_id.dart';
import '../constants/constants.dart';
import '../exception/could_not_build_thumbnail_exception.dart';
import '../extensions/get_collection_name_from_file_type.dart';
import '../extensions/get_image_data_aspect_ratio.dart';
import '../models/file_type.dart';
import '../typedefs/is_loading.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required XFile file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = image_package.decodeImage(await file.readAsBytes());
        if (fileAsImage == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException();
        }
        final imageThumb = image_package.copyResize(
          fileAsImage,
          width: ThumbConstants.imageThumbnailWidth,
        );
        final thumbnailData = image_package.encodeJpg(imageThumb);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final videoThumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
        );
        if (videoThumb == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException();
        }
        break;
    }
    final thumbAspectRatio = await thumbnailUint8List.getImageDataAspectRatio();

    final fileName = '${const Uuid().v4()}';

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionNames.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      final thumbnailUploadTask = await thumbnailRef.putData(
        thumbnailUint8List,
      );
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      final originalFileUploadTask = await originalFileRef.putData(
        await file.readAsBytes(),
      );
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        postSettings: postSettings,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.posts)
          .add(postPayload);
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
    }
  }
}
