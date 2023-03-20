import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/post_id.dart';
import '../../posts/typedefs/user_id.dart';

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) : super({
          FirebaseFieldNames.userID: userId,
          FirebaseFieldNames.postId: postId,
          FirebaseFieldNames.comment: comment,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
