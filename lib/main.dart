import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rivergram/state/auth/providers/auth_state_provider.dart';
import 'package:rivergram/views/components/loading/loading_screen.dart';

import 'firebase_options.dart';
import 'state/auth/backend/authenticator.dart';
import 'state/auth/constatnts/constants.dart';
import 'shared/theme/theme.dart';
import 'state/auth/providers/is_logged_in_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: Constants.facebookClientId,
      cookie: true,
      xfbml: true,
      version: "v14.0",
    );
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customTheme.copyWith(textTheme: customTextTheme),
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

/// when you are [logged In]
class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
            },
          ),
        ],
        title: Text(
          '${Authenticator().email ?? ' '}',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      body: Container(),
    );
  }
}

///when you are [ NOT Logged in ]
class LoginView extends ConsumerWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text("Login with Google")),
          ElevatedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).loginWithFacebook();
              },
              child: const Text("Login with Facebook")),
        ],
      ),
    );
  }
}
