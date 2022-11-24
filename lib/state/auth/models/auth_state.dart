import 'package:flutter/foundation.dart' show immutable;

import '../../posts/typedefs/user_id.dart';
import 'auth_result.dart';

@immutable
class AuthState {
  final AuthResult? authResult;
  final isLoading;
  final UserId? userId;

  const AuthState({
    required this.authResult,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unkown()
      : authResult = null,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoading) {
    return AuthState(
      authResult: authResult,
      isLoading: isLoading,
      userId: userId,
    );
  }

  @override
  bool operator ==(covariant AuthState other) {
    return identical(this, other) ||
        authResult == other.authResult &&
            isLoading == other.isLoading &&
            userId == other.userId;
  }

  @override
  int get hashCode => Object.hash(
        authResult,
        isLoading,
        userId,
      );
}
