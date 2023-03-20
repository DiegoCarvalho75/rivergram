import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firebase_collection_names.dart';
import '../../image_upload/typedefs/is_loading.dart';
import '../../posts/typedefs/post_id.dart';
import '../../posts/typedefs/user_id.dart';
import '../model/comment_payload.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    isLoading = true;
    final payload = CommentPayload(
      userId: userId,
      postId: postId,
      comment: comment,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.comments)
          .add(payload);
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
    }
  }
}
