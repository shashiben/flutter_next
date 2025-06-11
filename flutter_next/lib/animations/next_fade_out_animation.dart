import 'package:flutter/material.dart';
import '../flutter_next.dart';

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

  final Widget child;
  final Duration animationDuration;
  final Duration animationDelay;
  final AnimationController? animationController;
  final bool startAnimationImmediately;
  final double initialPosition;
  final NextFadeOutVariant? fadeOutVariant;
  final double viewportStart;
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
              return AnimatedBuilder(
                animation: controller,
                child: child,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: getOffset(animation),
                    child: Opacity(
                      opacity: 1 - opacity,
                      child: child,
                    ),
                  );
                },
              );
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
        return Offset.zero;
    }
  }

  Tween<double> getTween() {
    switch (fadeOutVariant) {
      case NextFadeOutVariant.fadeOutTop:
        return Tween<double>(end: initialPosition, begin: 0);
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
