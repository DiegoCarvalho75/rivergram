import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/posts/typedefs/user_id.dart';
import 'package:rivergram/state/user_info/models/user_info_model.dart';

import '../../constants/firebase_collection_names.dart';
import '../../constants/firebase_field_names.dart';

final userInfoModelProvider =
    StreamProvider.family.autoDispose<UserInfoModel, UserId>((
  ref,
  UserId userId,
) {
  final controller = StreamController<UserInfoModel>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .where(
        FirebaseFieldNames.userID,
        isEqualTo: userId,
      )
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final doc = snapshot.docs.first;
    final json = doc.data();
    final userInfoModel = UserInfoModel.fromJson(json, userId: userId);
    controller.add(userInfoModel);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
