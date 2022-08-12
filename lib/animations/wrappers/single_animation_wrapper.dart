import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';

class SingleAnimationWrapper<T> extends StatefulWidget {
  final Widget Function(AnimationController, T) child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final double viewPort;
  final Animation<T> Function(AnimationController) animation;

  const SingleAnimationWrapper(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 300),
      this.delay = const Duration(),
      this.controller,
      required this.animation,
      this.startAnimation = true,
      this.viewPort = 0.1})
      : super(key: key);

  @override
  State<SingleAnimationWrapper> createState() => _SingleAnimationWrapperState();
}

class _SingleAnimationWrapperState<T> extends State<SingleAnimationWrapper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<T> animation;
  bool isAnimated = false;

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
    animation = widget.animation(controller);
  }

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
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return widget.child(controller, animation.value);
          }),
    );
  }
}
