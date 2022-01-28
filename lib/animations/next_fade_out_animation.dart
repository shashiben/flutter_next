import '../flutter_next.dart';

class NextFadeOutAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final double initialPosition;
  final NextFadeOutVariant? variant;
  const NextFadeOutAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 750),
      this.delay = Duration.zero,
      this.variant,
      this.controller,
      this.startAnimation = true,
      this.initialPosition = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return variant == null
        ? SingleAnimationWrapper(
            child: (controller, value) => AnimatedOpacity(
                  opacity: 1 - (value as double),
                  duration: duration,
                  child: child,
                ),
            animation: (controller) =>
                CurvedAnimation(curve: Curves.easeOut, parent: controller))
        : DoubleAnimationWrapper(
            controller: controller,
            duration: duration,
            firstAnimation: (controller) => getTween().animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOut)),
            startAnimation: startAnimation,
            secondAnimation: (controller) => Tween<double>(begin: 0, end: 1)
                .animate(CurvedAnimation(
                    parent: controller, curve: const Interval(0, 0.7))),
            child: (AnimationController controller, dynamic animation,
                dynamic opacity) {
              return Transform.translate(
                  offset: getOffset(animation),
                  child: Opacity(
                    opacity: (1 - opacity).toDouble(),
                    child: child,
                  ));
            });
  }

  Offset getOffset(animation) {
    switch (variant) {
      case NextFadeOutVariant.fadeOutTop:
      case NextFadeOutVariant.fadeOutBottom:
        return Offset(0, animation);
      case NextFadeOutVariant.fadeOutLeft:
      case NextFadeOutVariant.fadeOutRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextFadeOutVariant.fadeOutTop:
        return Tween<double>(end: initialPosition * 1, begin: 0);
      case NextFadeOutVariant.fadeOutBottom:
        return Tween<double>(end: initialPosition * -1, begin: 0);
      case NextFadeOutVariant.fadeOutLeft:
        return Tween<double>(end: initialPosition * -1, begin: 0);
      case NextFadeOutVariant.fadeOutRight:
        return Tween<double>(end: initialPosition, begin: 0);
      default:
        return Tween<double>(end: initialPosition * -1, begin: 0);
    }
  }
}
