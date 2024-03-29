import 'package:flutter/material.dart';

import '../../../state/posts/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostThumbnailView({
    Key? key,
    required this.post,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Image.network(
          '${post.thumbnailUrl}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
