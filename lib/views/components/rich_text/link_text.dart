import 'package:flutter/foundation.dart' show immutable, VoidCallback;

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;

  LinkText({
    required this.onTapped,
    required super.text,
    super.textStyle,
  });
}
