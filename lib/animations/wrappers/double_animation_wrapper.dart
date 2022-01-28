import '../../flutter_next.dart';

class DoubleAnimationWrapper<T> extends StatefulWidget {
  final Duration duration;
  final bool startAnimation;
  final AnimationController? controller;
  final Duration delay;
  final Animation<T> Function(AnimationController controller) firstAnimation,
      secondAnimation;
  final Widget Function(AnimationController controller, T first, T second)
      child;
  const DoubleAnimationWrapper(
      {Key? key,
      required this.duration,
      this.startAnimation = true,
      this.delay = Duration.zero,
      this.controller,
      required this.firstAnimation,
      required this.secondAnimation,
      required this.child})
      : super(key: key);

  @override
  _DoubleAnimationWrapperState createState() => _DoubleAnimationWrapperState();
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
    if (widget.startAnimation) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return widget.child(
              controller, firstAnimation.value, secondAnimation.value);
        });
  }
}
