import 'package:flutter/material.dart';
import 'remove_all.dart';

extension AsHtmlColorToColor on String {
  Color asHtmlColorToColor() {
    return Color(
      int.parse(
        this.removeAll(['0x', '#']).padLeft(
          8,
          'ff',
        ),
        radix: 16,
      ),
    );
  }
}
