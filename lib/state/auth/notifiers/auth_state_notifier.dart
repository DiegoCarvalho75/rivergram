import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../user_info/backend/user_info_storage.dart';
import '../backend/authenticator.dart';
import '../models/auth_result.dart';
import '../models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
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
    final userid = _authenticator.userId;
    if (result == AuthResult.success && userid != null) {
      await null;
    }
  }
}
