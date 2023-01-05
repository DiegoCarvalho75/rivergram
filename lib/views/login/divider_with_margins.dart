import 'package:flutter/material.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: const Divider(),
    );
  }
}
