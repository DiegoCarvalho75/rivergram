import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../posts/typedefs/user_id.dart';
import '../constatnts/constants.dart';
import '../models/auth_result.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isLoggedIn => userId != null;
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print(e);
    }
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult =
        await FacebookAuth.instance.login(permissions: ['email']);
    final token = loginResult.accessToken?.token;
    if (token == null) {
      return AuthResult.abort;
    }
    final oAuthCredential = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCrededntial &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
      }
      return AuthResult.success;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          Constants.emailScope,
        ],
        clientId: Constants.googleClientId,
      );

      final signInAccount = await googleSignIn.signIn();
      if (signInAccount == null) {
        return AuthResult.abort;
      }
      final googleAuth = await signInAccount.authentication;
      final oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print(oAuthCredential.idToken);
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      return AuthResult.success;
    } catch (e) {
      print(e);
      return AuthResult.failure;
    }
  }
}
