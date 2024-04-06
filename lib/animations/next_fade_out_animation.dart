import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A [NextFadeOutAnimation] is a widget that provides fade out animations.
/// It takes a child widget and applies a fade out animation to it.
class NextFadeOutAnimation extends StatelessWidget {
  const NextFadeOutAnimation({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationDelay = Duration.zero,
    this.fadeOutVariant,
    this.viewportStart = 0.1,
    this.animationController,
    this.startAnimationImmediately = true,
    this.initialPosition = 100,
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

  /// The initial position from where the animation needs to begin.
  final double initialPosition;

  /// The type of fade out animation.
  final NextFadeOutVariant? fadeOutVariant;

  /// The viewport at which the animation should start.
  final double viewportStart;

  /// The key for the visibility widget.
  final Key? visibilityWidgetKey;

  @override
  Widget build(BuildContext context) {
    return fadeOutVariant == null
        ? SingleAnimationWrapper<double>(
            viewportStart: viewportStart,
            child: (AnimationController controller, double value) =>
                AnimatedOpacity(
                  opacity: 1 - value,
                  duration: animationDuration,
                  child: child,
                ),
            animation: (AnimationController controller) =>
                CurvedAnimation(curve: Curves.easeOut, parent: controller))
        : DoubleAnimationWrapper<double>(
            viewportStart: viewportStart,
            animationController: animationController,
            animationDuration: animationDuration,
            firstAnimation: (AnimationController controller) => getTween()
                .animate(
                    CurvedAnimation(parent: controller, curve: Curves.easeOut)),
            startAnimationImmediately: startAnimationImmediately,
            secondAnimation: (AnimationController controller) =>
                Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: controller, curve: const Interval(0, 0.7))),
            child: (AnimationController controller, double animation,
                double opacity) {
              return Transform.translate(
                  offset: getOffset(animation),
                  child: Opacity(
                    opacity: 1 - opacity,
                    child: child,
                  ));
            });
  }

  Offset getOffset(double animation) {
    switch (fadeOutVariant) {
      case NextFadeOutVariant.fadeOutTop:
      case NextFadeOutVariant.fadeOutBottom:
        return Offset(0, animation);
      case NextFadeOutVariant.fadeOutLeft:
      case NextFadeOutVariant.fadeOutRight:
        return Offset(animation, 0);
      case null:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (fadeOutVariant) {
      case NextFadeOutVariant.fadeOutTop:
        return Tween<double>(end: initialPosition * 1, begin: 0);
      case NextFadeOutVariant.fadeOutBottom:
        return Tween<double>(end: initialPosition * -1, begin: 0);
      case NextFadeOutVariant.fadeOutLeft:
        return Tween<double>(end: initialPosition * -1, begin: 0);
      case NextFadeOutVariant.fadeOutRight:
        return Tween<double>(end: initialPosition, begin: 0);
      case null:
        return Tween<double>(end: initialPosition * -1, begin: 0);
    }
  }
}
