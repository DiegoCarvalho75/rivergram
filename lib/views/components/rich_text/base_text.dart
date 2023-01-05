import 'package:flutter/material.dart'
    show TextStyle, Colors, TextDecoration, immutable, VoidCallback;

import 'link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? textStyle;

  BaseText({
    required this.text,
    this.textStyle,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? textStyle = const TextStyle(),
  }) {
    return BaseText(
      text: text, 
      textStyle: textStyle,
    );
  }

  factory BaseText.link({
    required VoidCallback onTapped,
    required String text,
    TextStyle? textStyle = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) {
    return LinkText(
      text: text,
      onTapped: onTapped,
      textStyle: textStyle,
    );
  }
}
