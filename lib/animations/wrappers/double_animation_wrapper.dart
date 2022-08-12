import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DoubleAnimationWrapper<T> extends StatefulWidget {
  final Duration duration;
  final bool startAnimation;
  final AnimationController? controller;
  final Duration delay;
  final Animation<T> Function(AnimationController controller) firstAnimation,
      secondAnimation;
  final Widget Function(AnimationController controller, T first, T second)
      child;
  final double viewPort;
  const DoubleAnimationWrapper(
      {Key? key,
      required this.duration,
      this.startAnimation = true,
      this.delay = Duration.zero,
      this.controller,
      required this.firstAnimation,
      required this.secondAnimation,
      this.viewPort = 0.1,
      required this.child})
      : super(key: key);

  @override
  State<DoubleAnimationWrapper> createState() => _DoubleAnimationWrapperState();
}

class _DoubleAnimationWrapperState<T> extends State<DoubleAnimationWrapper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<T> firstAnimation;
  late Animation<T> secondAnimation;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);
    firstAnimation = widget.firstAnimation(controller);
    secondAnimation = widget.secondAnimation(controller);
  }

  bool isAnimated = false;
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > widget.viewPort) {
          if (!isAnimated) {
            if (mounted && widget.startAnimation) {
              Future.delayed(widget.delay).then((value) {
                if (mounted) {
                  controller.forward().then((value) {
                    if (!isAnimated) {
                      setState(() => isAnimated = true);
                    }
                  });
                }
              });
            }
          }
        }
      },
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return widget.child(
                controller, firstAnimation.value, secondAnimation.value);
          }),
    );
  }
}
