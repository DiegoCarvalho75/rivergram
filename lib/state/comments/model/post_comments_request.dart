import 'package:flutter/foundation.dart';

import '../../../enums/date_sorting.dart';
import '../../posts/typedefs/post_id.dart';

@immutable
class PostCommentsRequest {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;
  const PostCommentsRequest({
    required this.postId,
    this.sortByCreatedAt = true,
    this.dateSorting = DateSorting.newstOnTop,
    this.limit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostCommentsRequest &&
        other.postId == postId &&
        other.sortByCreatedAt == sortByCreatedAt &&
        other.dateSorting == dateSorting &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      [
        postId,
        sortByCreatedAt,
        dateSorting,
        limit,
      ],
    );

    // return postId.hashCode ^
    //     sortByCreatedAt.hashCode ^
    //     dateSorting.hashCode ^
    //     limit.hashCode;
  }
}
