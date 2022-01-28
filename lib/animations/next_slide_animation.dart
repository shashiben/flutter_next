import '../flutter_next.dart';

class NextSlideAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final double initialPosition;
  final NextSlideVariant variant;
  const NextSlideAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 750),
      this.delay = Duration.zero,
      this.variant = NextSlideVariant.slideInLeft,
      this.controller,
      this.startAnimation = true,
      this.initialPosition = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleAnimationWrapper(
        duration: duration,
        startAnimation: startAnimation,
        delay: delay,
        controller: controller,
        child: (controller, value) {
          return Transform.translate(
            offset: getOffset(value),
            child: child,
          );
        },
        animation: (controller) => getTween().animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)));
  }

  Offset getOffset(animation) {
    switch (variant) {
      case NextSlideVariant.slideInTop:
        return Offset(0, animation);
      case NextSlideVariant.slideInBottom:
        return Offset(0, animation);
      case NextSlideVariant.slideInLeft:
      case NextSlideVariant.slideInRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextSlideVariant.slideInTop:
        return Tween<double>(begin: initialPosition, end: 0);
      case NextSlideVariant.slideInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextSlideVariant.slideInLeft:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextSlideVariant.slideInRight:
        return Tween<double>(begin: initialPosition, end: 0);
      default:
        return Tween<double>(begin: initialPosition * -1, end: 0);
    }
  }
}
