import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivergram/state/posts/typedefs/user_id.dart';

import '../../user_info/backend/user_info_storage.dart';
import '../backend/authenticator.dart';
import '../models/auth_result.dart';
import '../models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(AuthState.unkown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
        authResult: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logout();
    state = const AuthState.unkown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      authResult: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      authResult: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
