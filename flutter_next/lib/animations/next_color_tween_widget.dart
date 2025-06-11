import 'package:flutter/material.dart';

import 'wrappers/single_animation_wrapper.dart';

class NextColorTweenWidget extends StatelessWidget {
  const NextColorTweenWidget({
    super.key,
    required this.beginColor,
    required this.endColor,
    required this.child,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  final Color beginColor;
  final Color endColor;
  final Widget Function(AnimationController controller, Color? color) child;
  final AnimationController? controller;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return SingleAnimationWrapper<Color?>(
        animation: (controller) =>
            ColorTween(begin: beginColor, end: endColor).animate(controller),
        animationController: controller,
        child: (AnimationController controller, Color? value) {
          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext _, Widget? __) {
              return child(controller, value);
            },
          );
        });
  }
}
