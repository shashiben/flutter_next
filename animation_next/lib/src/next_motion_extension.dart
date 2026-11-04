import 'package:flutter/widgets.dart';

import 'animated/next_animated.dart';
import 'animated/next_animation.dart';
import 'next_motion.dart';
import 'next_motion_view.dart';

/// Short motion helpers on any widget.
extension NextMotionExtension on Widget {
  /// Fades this widget in.
  Widget fadeIn({
    NextFadeIn variant = NextFadeIn.fadeIn,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextFadeDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.fadeIn(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Fades this widget out.
  Widget fadeOut({
    NextFadeOut variant = NextFadeOut.fadeOut,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInCubic,
    double distance = kNextFadeDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.fadeOut(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Slides this widget.
  Widget slide({
    NextSlide variant = NextSlide.slideInLeft,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextSlideDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.slide(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Zooms this widget.
  Widget zoom({
    NextZoom variant = NextZoom.zoomIn,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.zoom(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Flips this widget.
  Widget flip({
    NextFlip variant = NextFlip.flipInX,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.flip(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Bounces this widget.
  Widget bounce({
    NextBounce variant = NextBounce.bounceIn,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve? curve,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
  }) {
    return NextMotionView.bounce(
      variant: variant,
      duration: duration,
      delay: delay,
      curve: curve,
      controller: controller,
      autoPlay: autoPlay,
      playWhenVisible: playWhenVisible,
      child: this,
    );
  }

  /// Plays [animations] on this widget.
  Widget animate(
    List<NextAnimation> animations, {
    Duration delay = Duration.zero,
    bool autoPlay = true,
    AnimationController? controller,
    bool playWhenVisible = false,
    double visibleFraction = 0.2,
    int repeat = 1,
    bool reverse = false,
    VoidCallback? onComplete,
    Alignment alignment = Alignment.center,
    double perspective = 800,
    Duration? inPoint,
    Duration? outPoint,
    Key? key,
  }) {
    return NextAnimated(
      key: key,
      animations: animations,
      delay: delay,
      autoPlay: autoPlay,
      controller: controller,
      playWhenVisible: playWhenVisible,
      visibleFraction: visibleFraction,
      repeat: repeat,
      reverse: reverse,
      onComplete: onComplete,
      alignment: alignment,
      perspective: perspective,
      inPoint: inPoint,
      outPoint: outPoint,
      child: this,
    );
  }
}
