import 'package:flutter/material.dart';
import '../flutter_next.dart';

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

  final Widget child;
  final Duration animationDuration;
  final Duration animationDelay;
  final AnimationController? animationController;
  final bool startAnimationImmediately;
  final NextSlideVariant? slideVariant;
  final double viewportStart;
  final Key? visibilityWidgetKey;
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
          return AnimatedBuilder(
            animation: controller,
            child: child,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: _getOffset(value),
                child: child,
              );
            },
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
        return Offset.zero;
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
