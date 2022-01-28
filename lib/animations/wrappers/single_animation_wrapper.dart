import '../../flutter_next.dart';

class SingleAnimationWrapper<T> extends StatefulWidget {
  final Widget Function(AnimationController, T) child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final Animation<T> Function(AnimationController) animation;

  const SingleAnimationWrapper(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 300),
      this.delay = const Duration(),
      this.controller,
      required this.animation,
      this.startAnimation = true})
      : super(key: key);

  @override
  _SingleAnimationWrapperState createState() => _SingleAnimationWrapperState();
}

class _SingleAnimationWrapperState<T> extends State<SingleAnimationWrapper<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<T> animation;

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
    if (widget.startAnimation && widget.delay.inMilliseconds == 0) {
      controller.forward();
    }

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return widget.child(controller, animation.value);
        });
  }
}
