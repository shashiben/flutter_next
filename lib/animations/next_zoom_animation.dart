import '../flutter_next.dart';

class NextZoomAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimationController? controller;
  final bool startAnimation;
  final double initialPosition;
  final NextZoomVariant variant;
  const NextZoomAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 750),
      this.delay = Duration.zero,
      this.variant = NextZoomVariant.zoomIn,
      this.controller,
      this.startAnimation = true,
      this.initialPosition = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleAnimationWrapper(
        controller: controller,
        duration: duration,
        firstAnimation: (controller) => getTween().animate(
            CurvedAnimation(curve: Curves.easeOut, parent: controller)),
        startAnimation: startAnimation,
        secondAnimation: (controller) => getOpacityTween().animate(
            CurvedAnimation(parent: controller, curve: const Interval(0, 0.7))),
        child: (AnimationController controller, dynamic animation,
            dynamic opacity) {
          return Transform.scale(
              scale: animation,
              child: Opacity(
                opacity: opacity,
                child: child,
              ));
        });
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextZoomVariant.zoomIn:
        return Tween(begin: 0.0, end: initialPosition);
      case NextZoomVariant.zoomOut:
        return Tween(begin: 1.0, end: initialPosition);
      default:
        return Tween(begin: 0.0, end: 1.0);
    }
  }

  Tween<double> getOpacityTween() {
    switch (variant) {
      case NextZoomVariant.zoomIn:
        return Tween<double>(begin: 0.0, end: 1.0);
      case NextZoomVariant.zoomOut:
        return Tween<double>(begin: 1.0, end: 0.0);
      default:
        return Tween<double>(begin: 0.0, end: 1.0);
    }
  }
}
