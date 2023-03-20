import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../constants/firebase_field_names.dart';
import '../../posts/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    this.email,
  }) : super({
          FirebaseFieldNames.userID: userId,
          FirebaseFieldNames.displayName: displayName,
          FirebaseFieldNames.email: email,
        });

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldNames.displayName] ?? '',
          email: json[FirebaseFieldNames.email],
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfoModel &&
        other.runtimeType == runtimeType &&
        other.userId == userId &&
        other.displayName == displayName &&
        other.email == email;
  }

  // @override
  // int get hashCode => userId.hashCode ^ displayName.hashCode ^ email.hashCode;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
        ],
      );
}
