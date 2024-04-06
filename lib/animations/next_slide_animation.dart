import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A [NextSlideAnimation] is a widget that provides slide animations.
/// It takes a child widget and applies a slide animation to it.
class NextSlideAnimation extends StatelessWidget {
  const NextSlideAnimation({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationDelay = Duration.zero,
    this.slideVariant = NextSlideVariant.slideInLeft,
    this.animationController,
    this.viewportStart = 0.1,
    this.startAnimationImmediately = true,
    this.initialAnimationPosition = 100,
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

  /// The type of slide animation.
  final NextSlideVariant? slideVariant;

  /// The viewport at which the animation should start.
  final double viewportStart;

  /// The key for the visibility widget.
  final Key? visibilityWidgetKey;

  /// The initial position from where the animation should start.
  final double initialAnimationPosition;

  @override
  Widget build(BuildContext context) {
    return SingleAnimationWrapper<double>(
        viewportStart: viewportStart,
        animationDuration: animationDuration,
        startAnimationImmediately: startAnimationImmediately,
        animationDelay: animationDelay,
        animationController: animationController,
        child: (AnimationController controller, double value) {
          return Transform.translate(
            offset: _getOffset(value),
            child: child,
          );
        },
        animation: (AnimationController controller) => _getTween().animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)));
  }

  Offset _getOffset(double animation) {
    switch (slideVariant) {
      case NextSlideVariant.slideInTop:
        return Offset(0, animation);
      case NextSlideVariant.slideInBottom:
        return Offset(0, animation);
      case NextSlideVariant.slideInLeft:
      case NextSlideVariant.slideInRight:
        return Offset(animation, 0);
      case null:
        return const Offset(0, 0);
    }
  }

  Tween<double> _getTween() {
    switch (slideVariant) {
      case NextSlideVariant.slideInTop:
        return Tween<double>(begin: initialAnimationPosition, end: 0);
      case NextSlideVariant.slideInBottom:
        return Tween<double>(begin: initialAnimationPosition * -1, end: 0);
      case NextSlideVariant.slideInLeft:
        return Tween<double>(begin: initialAnimationPosition * -1, end: 0);
      case NextSlideVariant.slideInRight:
        return Tween<double>(begin: initialAnimationPosition, end: 0);
      case null:
        return Tween<double>(begin: initialAnimationPosition * -1, end: 0);
    }
  }
}
