import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// This extension provides animation methods to the [Widget] class.
extension AnimationExtension on Widget {
  /// Wraps the widget with a bounce animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [initialPosition] - The initial position of the animation. Default is 100.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the bounce animation. Default is [NextBounceVariant.bounceInLeft].
  // Widget bounce({
  //   Duration duration = const Duration(milliseconds: 350),
  //   Duration delay = Duration.zero,
  //   AnimationController? controller,
  //   bool startAnimation = true,
  //   double initialPosition = 100,
  //   bool loop = false,
  //   double viewPort = 0.1,
  //   NextBounceVariant variant = NextBounceVariant.bounceInLeft,
  // }) {
  //   return NextBounceAnimation(
  //     duration: duration,
  //     delay: delay,
  //     viewPort: viewPort,
  //     controller: controller,
  //     initialPosition: initialPosition,
  //     startAnimation: startAnimation,
  //     variant: variant,
  //     child: this,
  //   );
  // }

  /// Wraps the widget with a fade in animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [initialPosition] - The initial position of the animation. Default is 100.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the fade in animation. Default is [NextFadeInVariant.fadeInLeft].
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 350),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool startAnimation = true,
    bool loop = false,
    double viewPort = 0.1,
    double initialPosition = 100,
    NextFadeInVariant variant = NextFadeInVariant.fadeInLeft,
  }) {
    return NextFadeInAnimation(
      animationDuration: duration,
      animationDelay: delay,
      animationController: controller,
      viewportStart: viewPort,
      initialPosition: initialPosition,
      startAnimationImmediately: startAnimation,
      fadeInVariant: variant,
      child: this,
    );
  }

  /// Wraps the widget with a fade out animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [initialPosition] - The initial position of the animation. Default is 100.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the fade out animation. Default is [NextFadeOutVariant.fadeOutLeft].
  Widget fadeOut({
    Duration duration = const Duration(milliseconds: 350),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool startAnimation = true,
    bool loop = false,
    double viewPort = 0.1,
    double initialPosition = 100,
    NextFadeOutVariant variant = NextFadeOutVariant.fadeOutLeft,
  }) {
    return NextFadeOutAnimation(
      animationDuration: duration,
      animationDelay: delay,
      animationController: controller,
      viewportStart: viewPort,
      initialPosition: initialPosition,
      startAnimationImmediately: startAnimation,
      fadeOutVariant: variant,
      child: this,
    );
  }

  /// Wraps the widget with a zoom animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [initialPosition] - The initial position of the animation. Default is 1.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the zoom animation. Default is [NextZoomVariant.zoomIn].
  Widget zoom({
    Duration duration = const Duration(milliseconds: 350),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool startAnimation = true,
    bool loop = false,
    double viewPort = 0.1,
    NextZoomVariant variant = NextZoomVariant.zoomIn,
  }) {
    return NextZoomAnimation(
      duration: duration,
      delay: delay,
      viewPort: viewPort,
      controller: controller,
      startAnimation: startAnimation,
      variant: variant,
      child: this,
    );
  }

  /// Wraps the widget with a slide animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [initialPosition] - The initial position of the animation. Default is 100.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the slide animation. Default is [NextSlideVariant.slideInLeft].
  Widget slide({
    Duration duration = const Duration(milliseconds: 350),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool startAnimation = true,
    bool loop = false,
    double viewPort = 0.1,
    double initialPosition = 100,
    NextSlideVariant variant = NextSlideVariant.slideInLeft,
  }) {
    return NextSlideAnimation(
      animationDuration: duration,
      animationDelay: delay,
      animationController: controller,
      startAnimationImmediately: startAnimation,
      slideVariant: variant,
      viewportStart: viewPort,
      initialAnimationPosition: initialPosition,
      child: this,
    );
  }

  /// Wraps the widget with a flip animation.
  ///
  /// [duration] - The duration of the animation. Default is 350 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - The controller for the animation.
  /// [startAnimation] - If true, the animation starts immediately. Default is true.
  /// [loop] - If true, the animation loops. Default is false.
  /// [viewPort] - The viewport at which the animation should start. Default is 0.1.
  /// [variant] - The variant of the flip animation. Default is [NextFlipVariant.flipX].
  Widget flip({
    Duration duration = const Duration(milliseconds: 350),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool startAnimation = true,
    bool loop = false,
    double viewPort = 0.1,
    NextFlipVariant variant = NextFlipVariant.flipX,
  }) {
    return NextFlipAnimation(
      animationDuration: duration,
      animationDelay: delay,
      animationController: controller,
      startAnimationImmediately: startAnimation,
      flipVariant: variant,
      viewportStart: viewPort,
      child: this,
    );
  }
}
