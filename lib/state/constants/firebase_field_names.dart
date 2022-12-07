import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldNames {
  static const userID = 'uid';
  static const postId = 'post_id';
  static const comment = 'comment';
  static const createdAt = 'created_at';
  static const date = 'date';
  static const displayName = 'display_name';
  static const email = 'email';

  const FirebaseFieldNames._();
}
