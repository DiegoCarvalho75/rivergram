import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './firebase_options.dart';
import './shared/theme.dart';
import './state/auth/backend/authenticator.dart';
import './state/auth/constatnts/constants.dart';

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
  runApp(const MyApp());
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
      theme: customTheme.copyWith(
        textTheme: customTextTheme,
      ),
      home: const Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: FittedBox(
                child: Text(
                  'Rivergram',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                child: Text(
                  '${Authenticator().email ?? ' '}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  !Authenticator().isLoggedIn
                      ? ElevatedButton(
                          onPressed: () async {
                            final result =
                                await Authenticator().loginWithGoogle();
                            print("result $result");
                          },
                          child: const Text("Login with Google"))
                      : ElevatedButton(
                          onPressed: () async {
                            await Authenticator().logout();
                            print("Logout");
                          },
                          child: const Text("Logout from Google")),
                  ElevatedButton(
                      onPressed: () async {
                        final login = await Authenticator().loginWithFacebook();
                        print("${login}");
                      },
                      child: const Text("Login with Facebook")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
