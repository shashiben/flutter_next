import '../flutter_next.dart';

extension AnimationExtension on Widget {
  Widget bounce(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      NextBounceVariant variant = NextBounceVariant.bounceInLeft}) {
    return NextBounceAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget fadeIn(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      NextFadeInVariant variant = NextFadeInVariant.fadeInLeft}) {
    return NextFadeInAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget fadeOut(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      NextFadeOutVariant variant = NextFadeOutVariant.fadeOutLeft}) {
    return NextFadeOutAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget zoom(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      NextZoomVariant variant = NextZoomVariant.zoomIn}) {
    return NextZoomAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget slide(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      NextSlideVariant variant = NextSlideVariant.slideInLeft}) {
    return NextSlideAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget flip(
      {Duration duration = const Duration(milliseconds: 700),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      NextFlipVariant variant = NextFlipVariant.flipX}) {
    return NextFlipAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      startAnimation: startAnimation,
      variant: variant,
    );
  }
}
