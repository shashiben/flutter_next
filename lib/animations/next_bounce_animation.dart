import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A widget that provides a bounce animation for its child.
///
/// The animation can be customized with the provided parameters.
class NextBounceAnimation extends StatelessWidget {
  /// Creates a new instance of [NextBounceAnimation].
  const NextBounceAnimation({
    super.key,
    this.viewPort = 0.1,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.delay = Duration.zero,
    this.variant = NextBounceVariant.bounceInLeft,
    this.controller,
    this.startAnimation = true,
    this.initialPosition = 100,
    this.visibilityKey,
  });

  /// The widget that will be animated.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The controller for the animation.
  final AnimationController? controller;

  /// Whether the animation should start as soon as the widget is built.
  final bool startAnimation;

  /// The initial position of the child widget.
  final double initialPosition;

  /// The variant of the bounce animation.
  final NextBounceVariant variant;

  /// The fraction of the viewport that the child should cover.
  final double viewPort;

  /// A key to identify the widget in tests.
  final Key? visibilityKey;

  /// Builds the widget tree for this widget.
  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper<double>(
      viewportStart: viewPort,
      animationController: controller,
      animationDuration: duration,
      firstAnimation: (AnimationController controller) => _getTween().animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceOut),
      ),
      startAnimationImmediately: startAnimation,
      secondAnimation: (AnimationController controller) =>
          Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.7)),
      ),
      child:
          (AnimationController controller, double animation, dynamic opacity) {
        return Transform.translate(
          offset: _getOffset(animation),
          child: child,
        );
      },
    );
  }

  /// Returns the offset for the child widget based on the animation value and the variant.
  Offset _getOffset(double animation) {
    switch (variant) {
      case NextBounceVariant.bounceInTop:
      case NextBounceVariant.bounceInBottom:
        return Offset(0, animation);
      case NextBounceVariant.bounceInLeft:
      case NextBounceVariant.bounceInRight:
        return Offset(animation, 0);
    }
  }

  /// Returns the tween for the animation based on the variant.
  Tween<double> _getTween() {
    switch (variant) {
      case NextBounceVariant.bounceInTop:
        return Tween<double>(begin: initialPosition * 1, end: 0);
      case NextBounceVariant.bounceInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextBounceVariant.bounceInLeft:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextBounceVariant.bounceInRight:
        return Tween<double>(begin: initialPosition, end: 0);
    }
  }
}
