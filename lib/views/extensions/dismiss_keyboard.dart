import 'package:flutter/material.dart';

extension DismissKeyboard on Widget {
  void dismissKeyboard() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }
}
