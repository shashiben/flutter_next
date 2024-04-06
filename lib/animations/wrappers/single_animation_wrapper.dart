import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A [SingleAnimationWrapper] is a widget that provides a single animation.
/// It takes a child widget and applies an animation to it.
class SingleAnimationWrapper<T> extends StatefulWidget {
  const SingleAnimationWrapper({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationDelay = Duration.zero,
    this.animationController,
    required this.animation,
    this.startAnimationImmediately = true,
    this.viewportStart = 0.1,
  });

  /// The child widget to which the animation is applied.
  final Widget Function(AnimationController, T) child;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The delay before the animation starts.
  final Duration animationDelay;

  /// The controller for the animation.
  final AnimationController? animationController;

  /// If true, the animation starts immediately.
  final bool startAnimationImmediately;

  /// The viewport at which the animation should start.
  final double viewportStart;

  /// The animation to be applied.
  final Animation<T> Function(AnimationController) animation;

  @override
  State<SingleAnimationWrapper<T>> createState() =>
      _SingleAnimationWrapperState<T>();
}

class _SingleAnimationWrapperState<T> extends State<SingleAnimationWrapper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<T> animation;
  bool isAnimated = false;

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
    animation = widget.animation(animationController);
  }

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
          Future<double>.delayed(widget.animationDelay).then((double? value) {
            if (mounted) {
              animationController.forward().then((dynamic value) {
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
            return widget.child(animationController, animation.value);
          }),
    );
  }
}
