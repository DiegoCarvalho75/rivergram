import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:rivergram/state/comments/model/post_comments_request.dart';
import 'package:rivergram/state/constants/firebase_collection_names.dart';

import '../../constants/firebase_field_names.dart';
import '../model/comment.dart';

final postCommentsProvider =
    StreamProvider.family.autoDispose<Iterable<Comment>, PostCommentsRequest>((
  ref,
  postCommentsRequest,
) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.comments)
      .where(
        FirebaseFieldNames.postId,
        isEqualTo: postCommentsRequest.postId,
      )
      .snapshots()
      .listen((snapshot) {
    final docs = snapshot.docs;
    final limitedDocs = postCommentsRequest.limit != null
        ? docs.take(postCommentsRequest.limit!)
        : docs;
    final comments = limitedDocs
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (comment) => Comment(
            comment.data(),
            id: comment.id,
          ),
        );
    final result = comments.apllySortingFrom(
      postCommentsRequest,
    );
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
