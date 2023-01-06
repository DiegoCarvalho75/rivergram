import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;
import '/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.asHtmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.asHtmlColorToColor();
  static final facebookColor = '#3b5998'.asHtmlColorToColor();
  const AppColors._();
}