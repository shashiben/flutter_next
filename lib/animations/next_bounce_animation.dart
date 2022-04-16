import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextBounceAnimation extends StatelessWidget {
  ///
  /// Child
  ///
  final Widget child;

  ///
  /// Duration of animation
  ///
  final Duration duration;

  ///
  /// Start animation after delay
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
  /// Initial position from where it needs to begin
  ///
  final double initialPosition;

  ///
  /// Provide variant type
  ///
  final NextBounceVariant variant;

  ///
  /// At which viewport the animation should start
  ///
  final double viewPort;

  ///
  /// Custom key for visibility widget
  ///
  final Key? visibilityKey;
  const NextBounceAnimation(
      {Key? key,
      this.viewPort = 0.1,
      required this.child,
      this.duration = const Duration(milliseconds: 350),
      this.delay = Duration.zero,
      this.variant = NextBounceVariant.bounceInLeft,
      this.controller,
      this.startAnimation = true,
      this.initialPosition = 100,
      this.visibilityKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper(
        viewPort: viewPort,
        controller: controller,
        duration: duration,
        firstAnimation: (controller) => getTween().animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceOut)),
        startAnimation: startAnimation,
        secondAnimation: (controller) => Tween<double>(begin: 0, end: 1)
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0, 0.7))),
        child: (AnimationController controller, dynamic animation,
            dynamic opacity) {
          return Transform.translate(
              offset: getOffset(animation),
              child: Opacity(
                opacity: opacity,
                child: child,
              ));
        });
  }

  Offset getOffset(animation) {
    switch (variant) {
      case NextBounceVariant.bounceInTop:
      case NextBounceVariant.bounceInBottom:
        return Offset(0, animation);
      case NextBounceVariant.bounceInLeft:
      case NextBounceVariant.bounceInRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextBounceVariant.bounceInTop:
        return Tween<double>(begin: initialPosition * 1, end: 0);
      case NextBounceVariant.bounceInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextBounceVariant.bounceInLeft:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextBounceVariant.bounceInRight:
        return Tween<double>(begin: initialPosition, end: 0);
      default:
        return Tween<double>(begin: initialPosition * -1, end: 0);
    }
  }
}
