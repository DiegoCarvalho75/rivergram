import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/post_id.dart';
import '../../posts/typedefs/user_id.dart';
import '../typedefs/comment_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId userId;
  final PostId postid;

  Comment(
    Map<String, dynamic> json, {
    required this.id,
  })  : comment = json[FirebaseFieldNames.comment],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        userId = json[FirebaseFieldNames.userID],
        postid = json[FirebaseFieldNames.postId];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.comment == comment &&
        other.createdAt == createdAt &&
        other.userId == userId &&
        other.postid == postid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        comment.hashCode ^
        createdAt.hashCode ^
        userId.hashCode ^
        postid.hashCode;
  }
}
