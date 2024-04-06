import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A [NextFadeInAnimation] is a widget that provides fade in animations.
/// It takes a child widget and applies a fade in animation to it.
class NextFadeInAnimation extends StatelessWidget {
  const NextFadeInAnimation({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationDelay = Duration.zero,
    this.fadeInVariant,
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

  /// The type of fade in animation.
  final NextFadeInVariant? fadeInVariant;

  /// The viewport at which the animation should start.
  final double viewportStart;

  /// The key for the visibility widget.
  final Key? visibilityWidgetKey;

  @override
  Widget build(BuildContext context) {
    return fadeInVariant == null
        ? SingleAnimationWrapper<double>(
            viewportStart: viewportStart,
            child: (AnimationController controller, double value) =>
                AnimatedOpacity(
                  opacity: value,
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
                    opacity: opacity,
                    child: child,
                  ));
            });
  }

  Offset getOffset(double animation) {
    switch (fadeInVariant) {
      case NextFadeInVariant.fadeInTop:
      case NextFadeInVariant.fadeInBottom:
        return Offset(0, animation);
      case NextFadeInVariant.fadeInLeft:
      case NextFadeInVariant.fadeInRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (fadeInVariant) {
      case NextFadeInVariant.fadeInTop:
        return Tween<double>(begin: initialPosition, end: 0);
      case NextFadeInVariant.fadeInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextFadeInVariant.fadeInLeft:
        return Tween<double>(begin: initialPosition, end: 0);
      case NextFadeInVariant.fadeInRight:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case null:
        return Tween<double>(begin: initialPosition * -1, end: 0);
    }
  }
}
