import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/views/components/animations/small_error_animation_view.dart';

import '../../state/image_upload/models/thumbnail_request.dart';
import '../../state/image_upload/providers/thumbnail_provider.dart';

import 'animations/loading_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  final ThumbnailRequest thumbnailRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));

    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      loading: () {
        return const LoadingAnimationView();
      },
      error: (error, stackTrace) {
        print(error);
        return const SmallErrorAnimationView();
      },
    );
  }
}
