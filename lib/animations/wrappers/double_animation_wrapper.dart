import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A [DoubleAnimationWrapper] is a widget that provides two animations.
/// It takes a child widget and applies two animations to it.
class DoubleAnimationWrapper<T> extends StatefulWidget {
  const DoubleAnimationWrapper({
    super.key,
    required this.animationDuration,
    this.startAnimationImmediately = true,
    this.animationDelay = Duration.zero,
    this.animationController,
    required this.firstAnimation,
    required this.secondAnimation,
    this.viewportStart = 0.1,
    required this.child,
  });

  /// The duration of the animation.
  final Duration animationDuration;

  /// If true, the animation starts immediately.
  final bool startAnimationImmediately;

  /// The controller for the animation.
  final AnimationController? animationController;

  /// The delay before the animation starts.
  final Duration animationDelay;

  /// The first and second animations to be applied.
  final Animation<T> Function(AnimationController controller) firstAnimation,
      secondAnimation;

  /// The child widget to which the animation is applied.
  final Widget Function(AnimationController controller, T first, T second)
      child;

  /// The viewport at which the animation should start.
  final double viewportStart;

  @override
  State<DoubleAnimationWrapper<T>> createState() =>
      _DoubleAnimationWrapperState<T>();
}

class _DoubleAnimationWrapperState<T> extends State<DoubleAnimationWrapper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<T> firstAnimation;
  late Animation<T> secondAnimation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = widget.animationController ??
        AnimationController(duration: widget.animationDuration, vsync: this);
    firstAnimation = widget.firstAnimation(animationController);
    secondAnimation = widget.secondAnimation(animationController);
  }

  bool isAnimated = false;
  final GlobalKey<State<StatefulWidget>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > widget.viewportStart &&
            !isAnimated &&
            mounted &&
            widget.startAnimationImmediately) {
          Future<Duration>.delayed(widget.animationDelay).then((Duration? value) {
            if (mounted) {
              animationController.forward().then((value) {
                if (!isAnimated) {
                  setState(() => isAnimated = true);
                }
              });
            }
          });
        }
      },
      child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return widget.child(animationController, firstAnimation.value,
                secondAnimation.value);
          }),
    );
  }
}
