import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rivergram/shared/theme.dart';
import 'package:rivergram/state/auth/constatnts/constants.dart';

import './state/auth/backend/authenticator.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: Constants.facebookClientId,
      cookie: true,
      xfbml: true,
      version: "v14.0",
    );
  }

  print(FacebookAuth.i.isWebSdkInitialized);

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
          children: [
            Text(
              'Rivergram',
              style: Theme.of(context).textTheme.headline4,
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
                  const Text(
                      "In veniam velit consequat ipsum laborum quis officia. Deserunt enim laboris aliqua duis incididunt voluptate ea nulla. Occaecat cupidatat ex culpa id irure dolore. Aute sit do duis duis quis sunt excepteur nisi aute id esse ."),
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Label")),
                    // cursofsfdsfsdfrColor: Colors.white,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final result = await Authenticator().loginWithGoogle();
                        print("result $result");
                      },
                      child: const Text("Login with Google")),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("Login with Facebook")),
                  Text(
                    "In veniam velit consequat ipsum laborum quis officia. Deserunt enim laboris aliqua duis incididunt voluptate ea nulla. Occaecat cupidatat ex culpa id irure dolore. Aute sit do duis duis quis sunt excepteur nisi aute id esse .",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
