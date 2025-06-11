import 'package:flutter/material.dart';
import '../flutter_next.dart';

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

  final Widget child;
  final Duration animationDuration;
  final Duration animationDelay;
  final AnimationController? animationController;
  final bool startAnimationImmediately;
  final NextFlipVariant? flipVariant;
  final double viewportStart;
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
        return AnimatedBuilder(
          animation: controller,
          child: child,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              alignment: FractionalOffset.center,
              transform: flipVariant == NextFlipVariant.flipY
                  ? (Matrix4.identity()..rotateX(first))
                  : (Matrix4.identity()..rotateY(first)),
              child: Opacity(
                opacity: second,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
