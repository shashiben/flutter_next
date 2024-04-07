import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextZoomAnimation extends StatelessWidget {
  const NextZoomAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.delay = Duration.zero,
    this.variant = NextZoomVariant.zoomIn,
    this.controller,
    this.viewPort = 0.1,
    this.startAnimation = true,
    this.visibilityKey,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final NextZoomVariant? variant;
  final double viewPort;
  final Key? visibilityKey;

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
          return AnimatedBuilder(
            animation: controller,
            child: child,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: animation,
                child: Opacity(
                  opacity: opacity,
                  child: child,
                ),
              );
            },
          );
        });
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextZoomVariant.zoomIn:
        return Tween(begin: 0.0, end: 1.0);
      case NextZoomVariant.zoomOut:
        return Tween(begin: 1.0, end: 0.0);
      case null:
        return Tween(begin: 0.0, end: 1.0);
    }
  }

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
