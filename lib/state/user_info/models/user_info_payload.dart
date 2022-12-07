import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart';
import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldNames.userID: userId,
          FirebaseFieldNames.displayName: displayName ?? '',
          FirebaseFieldNames.email: email ?? '',
        });
}
