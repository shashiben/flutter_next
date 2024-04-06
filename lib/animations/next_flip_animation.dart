import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A [NextFlipAnimation] is a widget that provides flip animations.
/// It takes a child widget and applies a flip animation to it.
class NextFlipAnimation extends StatelessWidget {
  const NextFlipAnimation({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationDelay = Duration.zero,
    this.animationController,
    this.viewportStart = 0.1,
    this.startAnimationImmediately = true,
    this.flipVariant = NextFlipVariant.flipX,
    this.visibilityWidgetKey,
  });

  /// The child widget to which the animation is applied.
  final Widget child;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The delay before the animation starts.
  final Duration animationDelay;

  /// The controller for the animation.
  final AnimationController? animationController;

  /// If true, the animation starts immediately.
  final bool startAnimationImmediately;

  /// The type of flip animation.
  final NextFlipVariant? flipVariant;

  /// The viewport at which the animation should start.
  final double viewportStart;

  /// The key for the visibility widget.
  final Key? visibilityWidgetKey;

  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper(
      viewportStart: viewportStart,
      animationDuration: animationDuration,
      startAnimationImmediately: startAnimationImmediately,
      animationDelay: animationDelay,
      animationController: animationController,
      firstAnimation: (AnimationController controller) =>
          Tween<double>(begin: 1.5, end: 0.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.bounceOut)),
      secondAnimation: (AnimationController controller) =>
          Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
              parent: controller, curve: const Interval(0, 0.7))),
      child: (AnimationController controller, double first, double second) {
        return Transform(
            alignment: FractionalOffset.center,
            transform: flipVariant == NextFlipVariant.flipY
                ? (Matrix4.identity()..rotateX(first))
                : (Matrix4.identity()..rotateY(first)),
            child: Opacity(
              opacity: second,
              child: child,
            ));
      },
    );
  }
}
