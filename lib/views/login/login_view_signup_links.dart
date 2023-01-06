import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rivergram/views/components/rich_text/base_text.dart';
import 'package:rivergram/views/components/rich_text/rich_text_widget.dart';

import '../constants/views_strings.dart';

class LoginViewSignupLinks extends StatelessWidget {
  LoginViewSignupLinks({
    Key? key,
    this.texts,
  }) : super(key: key);
  final Iterable<BaseText>? texts;

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(
            height: 1.5,
          ),
      texts: [
        BaseText.plain(text: ViewsStrings.dontHaveAnAccount),
        BaseText.plain(text: ViewsStrings.signUpOn),
        BaseText.link(
          text: ViewsStrings.facebook,
          onTapped: () {
            launchUrl(Uri.parse(ViewsStrings.facebookSignupUrl));
          },
        ),
        BaseText.plain(text: ViewsStrings.orCreateAnAccountOn),
        BaseText.link(
          text: ViewsStrings.google,
          onTapped: () {
            launchUrl(Uri.parse(ViewsStrings.google));
          },
        ),
      ],
    );
  }
}
