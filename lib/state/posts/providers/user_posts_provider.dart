import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/providers/user_id_provider.dart';

import '../../constants/firebase_collection_names.dart';
import '../../constants/firebase_field_names.dart';
import '../models/post.dart';
import '../models/post_key.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((
  ref,
) {
  final controller = StreamController<Iterable<Post>>();

  final userId = ref.watch(userIdProvider);

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.posts)
      .orderBy(FirebaseFieldNames.createdAt, descending: true)
      .where(
        PostKey.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final posts = documents
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
