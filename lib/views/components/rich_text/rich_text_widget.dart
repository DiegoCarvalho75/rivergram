import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'base_text.dart';
import 'link_text.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key,
    required this.texts,
    this.styleForAll,
  }) : super(key: key);
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(
                baseText.textStyle,
              ),
              recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(
                baseText.textStyle,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
