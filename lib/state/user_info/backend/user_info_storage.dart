import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_collection_names.dart';
import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/user_id.dart';
import '../models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionNames.users,
          )
          .where(
            FirebaseFieldNames.userID,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldNames.displayName: displayName,
          FirebaseFieldNames.email: email ?? '',
        });
        return true;
      }
      // user not found, create one
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionNames.users,
          )
          .add(payload);
      return true;
    } catch (e) {
      print("UserInfoStorage #49: $e");
      // rethrow;
      return false;
    }
  }
}
