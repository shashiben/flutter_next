import 'package:flutter/material.dart';
import '../flutter_next.dart';

extension AnimationExtension on Widget {
  Widget bounce(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      bool loop = false,
      double viewPort = 0.1,
      NextBounceVariant variant = NextBounceVariant.bounceInLeft}) {
    return NextBounceAnimation(
      child: this,
      duration: duration,
      delay: delay,
      viewPort: viewPort,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget fadeIn(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      bool loop = false,
      double viewPort = 0.1,
      double initialPosition = 100,
      NextFadeInVariant variant = NextFadeInVariant.fadeInLeft}) {
    return NextFadeInAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      viewPort: viewPort,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget fadeOut(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      double initialPosition = 100,
      bool loop = false,
      double viewPort = 0.1,
      NextFadeOutVariant variant = NextFadeOutVariant.fadeOutLeft}) {
    return NextFadeOutAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      viewPort: viewPort,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget zoom(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      bool loop = false,
      double viewPort = 0.1,
      double initialPosition = 1,
      NextZoomVariant variant = NextZoomVariant.zoomIn}) {
    return NextZoomAnimation(
      child: this,
      duration: duration,
      delay: delay,
      viewPort: viewPort,
      controller: controller,
      initialPosition: initialPosition,
      startAnimation: startAnimation,
      variant: variant,
    );
  }

  Widget slide(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool loop = false,
      double viewPort = 0.1,
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
      viewPort: viewPort,
      variant: variant,
    );
  }

  Widget flip(
      {Duration duration = const Duration(milliseconds: 350),
      Duration delay = Duration.zero,
      AnimationController? controller,
      bool startAnimation = true,
      bool loop = false,
      double viewPort = 0.1,
      NextFlipVariant variant = NextFlipVariant.flipX}) {
    return NextFlipAnimation(
      child: this,
      duration: duration,
      delay: delay,
      controller: controller,
      startAnimation: startAnimation,
      variant: variant,
      viewPort: viewPort,
    );
  }
}
