import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'models/lottie_animation.dart';

class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      ),
    );
  }
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$fileName.json';
}
