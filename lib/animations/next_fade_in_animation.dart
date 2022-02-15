import '../../flutter_next.dart';

class NextFadeInAnimation extends StatelessWidget {
  ///
  /// Child widget
  ///
  final Widget child;

  ///
  /// Duration of animation
  ///
  final Duration duration;

  ///
  /// Start animation after an delay
  ///
  final Duration delay;

  ///
  /// Add an controller to control animation
  ///
  final AnimationController? controller;

  ///
  /// if value is true, animation will be started immediately
  ///
  final bool startAnimation;

  ///
  /// Initial position from where it needs to begin
  ///
  final double initialPosition;

  ///
  /// Provide variant type
  ///
  final NextFadeInVariant? variant;

  ///
  /// Should animation need to loop continuously
  ///
  final bool loop;

  ///
  /// At which viewport the animation should start
  ///
  final double viewPort;

  ///
  /// Custom key for visibility widget
  ///
  final Key? visibilityKey;

  const NextFadeInAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 350),
      this.delay = Duration.zero,
      this.loop = false,
      this.viewPort = 0.1,
      this.variant,
      this.controller,
      this.startAnimation = true,
      this.initialPosition = 100,
      this.visibilityKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return variant == null
        ? SingleAnimationWrapper(
            loop: loop,
            viewPort: viewPort,
            child: (controller, value) => AnimatedOpacity(
                  opacity: value as double,
                  duration: duration,
                  child: child,
                ),
            animation: (controller) =>
                CurvedAnimation(curve: Curves.easeOut, parent: controller))
        : DoubleAnimationWrapper(
            loop: loop,
            viewPort: viewPort,
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
                    opacity: opacity,
                    child: child,
                  ));
            });
  }

  Offset getOffset(animation) {
    switch (variant) {
      case NextFadeInVariant.fadeInTop:
      case NextFadeInVariant.fadeInBottom:
        return Offset(0, animation);
      case NextFadeInVariant.fadeInLeft:
      case NextFadeInVariant.fadeInRight:
        return Offset(animation, 0);
      default:
        return const Offset(0, 0);
    }
  }

  Tween<double> getTween() {
    switch (variant) {
      case NextFadeInVariant.fadeInTop:
        return Tween<double>(begin: initialPosition * 1, end: 0);
      case NextFadeInVariant.fadeInBottom:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      case NextFadeInVariant.fadeInLeft:
        return Tween<double>(begin: initialPosition * 1, end: 0);
      case NextFadeInVariant.fadeInRight:
        return Tween<double>(begin: initialPosition * -1, end: 0);
      default:
        return Tween<double>(begin: initialPosition * -1, end: 0);
    }
  }
}
