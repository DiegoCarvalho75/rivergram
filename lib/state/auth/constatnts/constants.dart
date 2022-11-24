import 'package:flutter/foundation.dart';

@immutable
class Constants {
  static const accountExistsWithDifferentCrededntial =
      "account-exists-with-different-crededntial";
  static const googleCom = "google.com";
  static const emailScope = "email";
  static const String googleClientId = String.fromEnvironment(
    'googleClientId',
  );
  static const String facebookClientId = String.fromEnvironment(
    'facebookClientId',
  );
  const Constants._();
}
