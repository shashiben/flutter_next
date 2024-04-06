import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A widget that applies a zoom animation to its child.
///
/// The animation is controlled by an [AnimationController] and the zoom variant
/// is specified by [variant]. The animation can be delayed by [delay] and its
/// duration is specified by [duration]. The animation starts immediately if
/// [startAnimation] is true.
class NextZoomAnimation extends StatelessWidget {
  /// Creates a new instance of [NextZoomAnimation].
  const NextZoomAnimation(
      {super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 350),
      this.delay = Duration.zero,
      this.variant = NextZoomVariant.zoomIn,
      this.controller,
      this.viewPort = 0.1,
      this.startAnimation = true,
      this.initialPosition = 1,
      this.visibilityKey});

  /// The child widget to apply the animation to.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The controller for the animation.
  final AnimationController? controller;

  /// Whether the animation should start immediately.
  final bool startAnimation;

  /// The variant of the zoom animation.
  final NextZoomVariant? variant;

  /// The viewport at which the animation should start.
  final double viewPort;

  /// The key for the visibility widget.
  final Key? visibilityKey;

  /// The initial position of the animation.
  final double initialPosition;

  /// Builds the widget tree for this widget.
  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper<double>(
        viewportStart: viewPort,
        animationController: controller,
        animationDuration: duration,
        firstAnimation: (AnimationController controller) => getTween().animate(
            CurvedAnimation(curve: Curves.easeOut, parent: controller)),
        startAnimationImmediately: startAnimation,
        secondAnimation: (AnimationController controller) => getOpacityTween()
            .animate(CurvedAnimation(
                parent: controller, curve: const Interval(0, 0.7))),
        child:
            (AnimationController controller, double animation, double opacity) {
          return Transform.scale(
              scale: animation,
              child: Opacity(
                opacity: opacity,
                child: child,
              ));
        });
  }

  /// Returns the tween for the zoom animation.
  Tween<double> getTween() {
    switch (variant) {
      case NextZoomVariant.zoomIn:
        return Tween(begin: 0.0, end: initialPosition);
      case NextZoomVariant.zoomOut:
        return Tween(begin: 1.0, end: initialPosition);
      case null:
        return Tween(begin: 0.0, end: 1.0);
    }
  }

  /// Returns the tween for the opacity animation.
  Tween<double> getOpacityTween() {
    switch (variant) {
      case NextZoomVariant.zoomIn:
        return Tween<double>(begin: 0.0, end: 1.0);
      case NextZoomVariant.zoomOut:
        return Tween<double>(begin: 1.0, end: 0.0);
      case null:
        return Tween<double>(begin: 0.0, end: 1.0);
    }
  }
}
