import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextSlideAnimation extends StatelessWidget {
  ///
  /// Child widget
  ///
  final Widget child;

  ///
  /// Duration of animation
  ///
  final Duration duration;

  ///
  /// Start animation after an delay
  ///
  final Duration delay;

  ///
  /// Add an controller to control animation
  ///
  final AnimationController? controller;

  ///
  /// if value is true, animation will be started immediately
  ///
  final bool startAnimation;

  ///
  /// Provide variant type
  ///
  final NextSlideVariant? variant;

  ///
  /// Should animation need to loop continuously
  ///
  final bool loop;

  ///
  /// At which viewport the animation should start
  ///
  final double viewPort;

  ///
  /// Custom key for visibility widget
  ///
  final Key? visibilityKey;

  ///
  /// Initial position from where it needs to begin
  ///
  final double initialPosition;

  const NextSlideAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 350),
      this.delay = Duration.zero,
      this.variant = NextSlideVariant.slideInLeft,
      this.controller,
      this.loop = false,
      this.viewPort = 0.1,
      this.startAnimation = true,
      this.initialPosition = 100,
      this.visibilityKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleAnimationWrapper(
        loop: loop,
        viewPort: viewPort,
        duration: duration,
        startAnimation: startAnimation,
        delay: delay,
        controller: controller,
        child: (controller, value) {
          return Transform.translate(
            offset: getOffset(value),
            child: child,
          );
        },
        animation: (controller) => getTween().animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)));
  }

  Offset getOffset(animation) {
    switch (variant) {
      case NextSlideVariant.slideInTop:
        return Offset(0, animation);
      case NextSlideVariant.slideInBottom:
        return Offset(0, animation);
      case NextSlideVariant.slideInLeft:
      case NextSlideVariant.slideInRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextSlideVariant.slideInTop:
        return Tween<double>(begin: initialPosition, end: 0);
      case NextSlideVariant.slideInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextSlideVariant.slideInLeft:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextSlideVariant.slideInRight:
        return Tween<double>(begin: initialPosition, end: 0);
      default:
        return Tween<double>(begin: initialPosition * -1, end: 0);
    }
  }
}
