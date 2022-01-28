import '../flutter_next.dart';

class NextFlipAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final NextFlipVariant variant;
  const NextFlipAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 750),
      this.delay = Duration.zero,
      this.controller,
      this.startAnimation = true,
      this.variant = NextFlipVariant.flipX})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper(
      duration: duration,
      startAnimation: startAnimation,
      delay: delay,
      controller: controller,
      firstAnimation: (controller) => Tween<double>(begin: 1.5, end: 0.0)
          .animate(
              CurvedAnimation(parent: controller, curve: Curves.bounceOut)),
      secondAnimation: (controller) => Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: controller, curve: const Interval(0, 0.7))),
      child: (controller, first, second) {
        return Transform(
            alignment: FractionalOffset.center,
            transform: variant == NextFlipVariant.flipY
                ? (Matrix4.identity()..rotateX(first as double))
                : (Matrix4.identity()..rotateY(first as double)),
            child: Opacity(
              opacity: second as double,
              child: child,
            ));
      },
    );
  }
}
