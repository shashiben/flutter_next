import 'package:flutter/material.dart';
import '../animations/next_fade_in_animation.dart';
import '../animations/next_fade_out_animation.dart';
import '../animations/next_flip_animation.dart';
import '../animations/next_slide_animation.dart';
import '../animations/next_zoom_animation.dart';
import '../enums.dart';

/// Extension methods for adding animations to widgets.
///
/// This extension provides convenient methods to wrap widgets with various
/// animation types. All animations start automatically when the widget is built,
/// making them perfect for creating smooth, polished UI transitions.
///
/// **Example:**
/// ```dart
/// Container(
///   width: 100,
///   height: 100,
///   color: Colors.blue,
/// ).fadeIn(
///   variant: NextFadeInVariant.fadeInLeft,
///   duration: Duration(milliseconds: 500),
/// )
/// ```
extension AnimationExtension on Widget {
  /// Wraps the widget with a fade in animation.
  ///
  /// [duration] - The duration of the animation. Default is 400 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [variant] - The variant of the fade in animation. Default is [NextFadeInVariant.fadeInLeft].
  /// [controller] - Optional controller for manual animation control.
  /// [autoStart] - If true, the animation starts automatically. Default is true.
  /// [initialPosition] - The initial position offset. Default is 50 pixels.
  /// [curve] - The animation curve. Default is [Curves.easeOutCubic].
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    NextFadeInVariant? variant,
    AnimationController? controller,
    bool autoStart = true,
    double initialPosition = 50,
    Curve curve = Curves.easeOutCubic,
  }) {
    return NextFadeInAnimation(
      duration: duration,
      delay: delay,
      variant: variant,
      controller: controller,
      autoStart: autoStart,
      initialPosition: initialPosition,
      curve: curve,
      child: this,
    );
  }

  /// Wraps the widget with a fade out animation.
  ///
  /// [duration] - The duration of the animation. Default is 400 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [variant] - The variant of the fade out animation. Default is [NextFadeOutVariant.fadeOutLeft].
  /// [controller] - Optional controller for manual animation control.
  /// [autoStart] - If true, the animation starts automatically. Default is true.
  /// [initialPosition] - The initial position offset. Default is 50 pixels.
  /// [curve] - The animation curve. Default is [Curves.easeInCubic].
  Widget fadeOut({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    NextFadeOutVariant? variant,
    AnimationController? controller,
    bool autoStart = true,
    double initialPosition = 50,
    Curve curve = Curves.easeInCubic,
  }) {
    return NextFadeOutAnimation(
      duration: duration,
      delay: delay,
      variant: variant,
      controller: controller,
      autoStart: autoStart,
      initialPosition: initialPosition,
      curve: curve,
      child: this,
    );
  }

  /// Wraps the widget with a zoom animation.
  ///
  /// [duration] - The duration of the animation. Default is 400 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [controller] - Optional controller for manual animation control.
  /// [autoStart] - If true, the animation starts automatically. Default is true.
  /// [curve] - The animation curve. Default is [Curves.easeOutCubic].
  /// [variant] - The variant of the zoom animation. Default is [NextZoomVariant.zoomIn].
  Widget zoom({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    AnimationController? controller,
    bool autoStart = true,
    Curve curve = Curves.easeOutCubic,
    NextZoomVariant variant = NextZoomVariant.zoomIn,
  }) {
    return NextZoomAnimation(
      duration: duration,
      delay: delay,
      controller: controller,
      autoStart: autoStart,
      variant: variant,
      curve: curve,
      child: this,
    );
  }

  /// Wraps the widget with a slide animation.
  ///
  /// [duration] - The duration of the animation. Default is 400 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [variant] - The variant of the slide animation. Default is [NextSlideVariant.slideInLeft].
  /// [controller] - Optional controller for manual animation control.
  /// [autoStart] - If true, the animation starts automatically. Default is true.
  /// [initialPosition] - The initial position offset. Default is 100 pixels.
  /// [curve] - The animation curve. Default is [Curves.easeOutCubic].
  Widget slide({
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    NextSlideVariant variant = NextSlideVariant.slideInLeft,
    AnimationController? controller,
    bool autoStart = true,
    double initialPosition = 100,
    Curve curve = Curves.easeOutCubic,
  }) {
    return NextSlideAnimation(
      duration: duration,
      delay: delay,
      variant: variant,
      controller: controller,
      autoStart: autoStart,
      initialPosition: initialPosition,
      curve: curve,
      child: this,
    );
  }

  /// Wraps the widget with a flip animation.
  ///
  /// [duration] - The duration of the animation. Default is 600 milliseconds.
  /// [delay] - The delay before the animation starts. Default is zero.
  /// [variant] - The variant of the flip animation. Default is [NextFlipVariant.flipX].
  /// [controller] - Optional controller for manual animation control.
  /// [autoStart] - If true, the animation starts automatically. Default is true.
  /// [curve] - The animation curve. Default is [Curves.easeInOut].
  Widget flip({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    NextFlipVariant variant = NextFlipVariant.flipX,
    AnimationController? controller,
    bool autoStart = true,
    Curve curve = Curves.easeInOut,
  }) {
    return NextFlipAnimation(
      duration: duration,
      delay: delay,
      variant: variant,
      controller: controller,
      autoStart: autoStart,
      curve: curve,
      child: this,
    );
  }
}
