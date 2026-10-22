import 'dart:math' as math;

import 'package:flutter/animation.dart';

/// Progress of a motion after [delay], shaped by [curve].
///
/// [t] is the controller value from 0 to 1 across `delay + duration`.
double nextMotionT({
  required double t,
  required Duration delay,
  required Duration duration,
  required Curve curve,
}) {
  final total = delay.inMicroseconds + duration.inMicroseconds;
  if (total <= 0) {
    return 1;
  }
  final delayFraction = delay.inMicroseconds / total;
  if (t <= delayFraction) {
    return 0;
  }
  final span = 1 - delayFraction;
  final local = span == 0 ? 1.0 : ((t - delayFraction) / span).clamp(0.0, 1.0);
  return curve.transform(local.toDouble());
}

/// How a widget moves, fades, scales, or rotates.
class NextMotion {
  /// Creates a motion. Values are the start and end of the played range.
  const NextMotion({
    this.opacityBegin = 1,
    this.opacityEnd = 1,
    this.dxBegin = 0,
    this.dyBegin = 0,
    this.dxEnd = 0,
    this.dyEnd = 0,
    this.scaleBegin = 1,
    this.scaleEnd = 1,
    this.rotateXBegin = 0,
    this.rotateXEnd = 0,
    this.rotateYBegin = 0,
    this.rotateYEnd = 0,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.playWhenVisible = false,
  });

  /// Opacity at the start of the motion.
  final double opacityBegin;

  /// Opacity at the end of the motion.
  final double opacityEnd;

  /// Horizontal offset at the start, in logical pixels.
  final double dxBegin;

  /// Vertical offset at the start, in logical pixels.
  final double dyBegin;

  /// Horizontal offset at the end.
  final double dxEnd;

  /// Vertical offset at the end.
  final double dyEnd;

  /// Scale at the start.
  final double scaleBegin;

  /// Scale at the end.
  final double scaleEnd;

  /// X rotation at the start, in radians.
  final double rotateXBegin;

  /// X rotation at the end, in radians.
  final double rotateXEnd;

  /// Y rotation at the start, in radians.
  final double rotateYBegin;

  /// Y rotation at the end, in radians.
  final double rotateYEnd;

  /// Length of the motion, not including [delay].
  final Duration duration;

  /// Time spent on the start values before the motion begins.
  final Duration delay;

  /// Curve applied to the motion interval.
  final Curve curve;

  /// When true, playback starts once the widget is on screen.
  final bool playWhenVisible;

  /// A copy with the given fields replaced.
  NextMotion copyWith({
    double? opacityBegin,
    double? opacityEnd,
    double? dxBegin,
    double? dyBegin,
    double? dxEnd,
    double? dyEnd,
    double? scaleBegin,
    double? scaleEnd,
    double? rotateXBegin,
    double? rotateXEnd,
    double? rotateYBegin,
    double? rotateYEnd,
    Duration? duration,
    Duration? delay,
    Curve? curve,
    bool? playWhenVisible,
  }) {
    return NextMotion(
      opacityBegin: opacityBegin ?? this.opacityBegin,
      opacityEnd: opacityEnd ?? this.opacityEnd,
      dxBegin: dxBegin ?? this.dxBegin,
      dyBegin: dyBegin ?? this.dyBegin,
      dxEnd: dxEnd ?? this.dxEnd,
      dyEnd: dyEnd ?? this.dyEnd,
      scaleBegin: scaleBegin ?? this.scaleBegin,
      scaleEnd: scaleEnd ?? this.scaleEnd,
      rotateXBegin: rotateXBegin ?? this.rotateXBegin,
      rotateXEnd: rotateXEnd ?? this.rotateXEnd,
      rotateYBegin: rotateYBegin ?? this.rotateYBegin,
      rotateYEnd: rotateYEnd ?? this.rotateYEnd,
      duration: duration ?? this.duration,
      delay: delay ?? this.delay,
      curve: curve ?? this.curve,
      playWhenVisible: playWhenVisible ?? this.playWhenVisible,
    );
  }

  /// Fade in from [variant].
  static NextMotion fadeIn(
    NextFadeIn variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextFadeDistance,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.fadeIn(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Fade out along [variant].
  static NextMotion fadeOut(
    NextFadeOut variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInCubic,
    double distance = kNextFadeDistance,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.fadeOut(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Slide along [variant].
  static NextMotion slide(
    NextSlide variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextSlideDistance,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.slide(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      distance: distance,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Zoom along [variant].
  static NextMotion zoom(
    NextZoom variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.zoom(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Bounce along [variant].
  static NextMotion bounce(
    NextBounce variant, {
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve? curve,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.bounce(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Flip along [variant].
  static NextMotion flip(
    NextFlip variant, {
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    bool playWhenVisible = false,
  }) {
    return _MotionPresets.flip(
      variant,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }
}

/// Fade-in directions. `Up` starts below and moves up. `Down` starts above.
enum NextFadeIn {
  /// Opacity only.
  fadeIn,

  /// From the left.
  fadeInLeft,

  /// From the right.
  fadeInRight,

  /// From below.
  fadeInUp,

  /// From above.
  fadeInDown,

  /// From the left, farther away.
  fadeInLeftBig,

  /// From the right, farther away.
  fadeInRightBig,

  /// From below, farther away.
  fadeInUpBig,

  /// From above, farther away.
  fadeInDownBig,

  /// From the top-left corner.
  fadeInTopLeft,

  /// From the top-right corner.
  fadeInTopRight,

  /// From the bottom-left corner.
  fadeInBottomLeft,

  /// From the bottom-right corner.
  fadeInBottomRight,
}

/// Fade-out directions. The widget leaves along the named direction.
enum NextFadeOut {
  /// Opacity only.
  fadeOut,

  /// Toward the left.
  fadeOutLeft,

  /// Toward the right.
  fadeOutRight,

  /// Toward the top.
  fadeOutUp,

  /// Toward the bottom.
  fadeOutDown,

  /// Toward the left, farther away.
  fadeOutLeftBig,

  /// Toward the right, farther away.
  fadeOutRightBig,

  /// Toward the top, farther away.
  fadeOutUpBig,

  /// Toward the bottom, farther away.
  fadeOutDownBig,

  /// Toward the top-left corner.
  fadeOutTopLeft,

  /// Toward the top-right corner.
  fadeOutTopRight,

  /// Toward the bottom-left corner.
  fadeOutBottomLeft,

  /// Toward the bottom-right corner.
  fadeOutBottomRight,
}

/// Slide directions.
enum NextSlide {
  /// From above.
  slideInDown,

  /// From below.
  slideInUp,

  /// From the left.
  slideInLeft,

  /// From the right.
  slideInRight,

  /// Toward the top.
  slideOutUp,

  /// Toward the bottom.
  slideOutDown,

  /// Toward the left.
  slideOutLeft,

  /// Toward the right.
  slideOutRight,
}

/// Zoom directions.
enum NextZoom {
  /// Scale up at the center.
  zoomIn,

  /// Scale up from above.
  zoomInDown,

  /// Scale up from the left.
  zoomInLeft,

  /// Scale up from the right.
  zoomInRight,

  /// Scale up from below.
  zoomInUp,

  /// Scale down at the center.
  zoomOut,

  /// Scale down toward the bottom.
  zoomOutDown,

  /// Scale down toward the left.
  zoomOutLeft,

  /// Scale down toward the right.
  zoomOutRight,

  /// Scale down toward the top.
  zoomOutUp,
}

/// Bounce directions.
enum NextBounce {
  /// Scale in at the center.
  bounceIn,

  /// Bounce in from above.
  bounceInDown,

  /// Bounce in from below.
  bounceInUp,

  /// Bounce in from the left.
  bounceInLeft,

  /// Bounce in from the right.
  bounceInRight,

  /// Scale out at the center.
  bounceOut,

  /// Bounce out toward the top.
  bounceOutUp,

  /// Bounce out toward the bottom.
  bounceOutDown,

  /// Bounce out toward the left.
  bounceOutLeft,

  /// Bounce out toward the right.
  bounceOutRight,
}

/// Flip axis and direction.
enum NextFlip {
  /// Rotate in around X.
  flipInX,

  /// Rotate in around Y.
  flipInY,

  /// Rotate out around X.
  flipOutX,

  /// Rotate out around Y.
  flipOutY,
}

/// Default travel distance for fades, in logical pixels.
const double kNextFadeDistance = 50;

/// Default travel distance for slides, in logical pixels.
const double kNextSlideDistance = 100;

extension _NamedShift on Enum {
  ({double dx, double dy}) shift(double distance) {
    final far = name.contains('Big');
    final travel = far ? distance * 4 : distance;
    var dx = 0.0;
    var dy = 0.0;
    if (name.contains('Left')) {
      dx = -travel;
    }
    if (name.contains('Right')) {
      dx = travel;
    }
    final outward = name.contains('Out');
    if (outward) {
      if (name.contains('Up') || name.contains('Top')) {
        dy = -travel;
      }
      if (name.contains('Down') || name.contains('Bottom')) {
        dy = travel;
      }
    } else {
      if (name.contains('Up') || name.contains('Bottom')) {
        dy = travel;
      }
      if (name.contains('Down') || name.contains('Top')) {
        dy = -travel;
      }
    }
    return (dx: dx, dy: dy);
  }
}

extension _MotionPresets on NextMotion {
  /// Fade in from [variant].
  static NextMotion fadeIn(
    NextFadeIn variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextFadeDistance,
    bool playWhenVisible = false,
  }) {
    final shift = variant.shift(distance);
    return NextMotion(
      opacityBegin: 0,
      opacityEnd: 1,
      dxBegin: shift.dx,
      dyBegin: shift.dy,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Fade out toward [variant].
  static NextMotion fadeOut(
    NextFadeOut variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInCubic,
    double distance = kNextFadeDistance,
    bool playWhenVisible = false,
  }) {
    final shift = variant.shift(distance);
    return NextMotion(
      opacityBegin: 1,
      opacityEnd: 0,
      dxEnd: shift.dx,
      dyEnd: shift.dy,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Slide in from [variant].
  static NextMotion slide(
    NextSlide variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextSlideDistance,
    bool playWhenVisible = false,
  }) {
    final entering = variant.name.contains('In');
    final shift = variant.shift(distance);
    return NextMotion(
      dxBegin: entering ? shift.dx : 0,
      dyBegin: entering ? shift.dy : 0,
      dxEnd: entering ? 0 : shift.dx,
      dyEnd: entering ? 0 : shift.dy,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Zoom according to [variant].
  static NextMotion zoom(
    NextZoom variant, {
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    bool playWhenVisible = false,
  }) {
    final entering = variant.name.startsWith('zoomIn');
    final shift = variant.shift(40);
    return NextMotion(
      opacityBegin: entering ? 0 : 1,
      opacityEnd: entering ? 1 : 0,
      scaleBegin: entering ? 0.6 : 1,
      scaleEnd: entering ? 1 : 0.6,
      dxBegin: entering ? shift.dx : 0,
      dyBegin: entering ? shift.dy : 0,
      dxEnd: entering ? 0 : shift.dx,
      dyEnd: entering ? 0 : shift.dy,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }

  /// Bounce according to [variant].
  static NextMotion bounce(
    NextBounce variant, {
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve? curve,
    bool playWhenVisible = false,
  }) {
    final entering = variant.name.startsWith('bounceIn');
    final shift = variant.shift(40);
    return NextMotion(
      opacityBegin: entering ? 0 : 1,
      opacityEnd: entering ? 1 : 0,
      scaleBegin: entering ? 0.3 : 1,
      scaleEnd: entering ? 1 : 0.3,
      dxBegin: entering ? shift.dx : 0,
      dyBegin: entering ? shift.dy : 0,
      dxEnd: entering ? 0 : shift.dx,
      dyEnd: entering ? 0 : shift.dy,
      duration: duration,
      delay: delay,
      curve: curve ?? (entering ? Curves.elasticOut : Curves.elasticIn),
      playWhenVisible: playWhenVisible,
    );
  }

  /// Flip according to [variant].
  static NextMotion flip(
    NextFlip variant, {
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    bool playWhenVisible = false,
  }) {
    final entering = variant.name.contains('In');
    final aroundX = variant.name.endsWith('X');
    const quarter = math.pi / 2;
    return NextMotion(
      opacityBegin: entering ? 0 : 1,
      opacityEnd: entering ? 1 : 0,
      rotateXBegin: aroundX && entering ? quarter : 0,
      rotateXEnd: aroundX && !entering ? quarter : 0,
      rotateYBegin: !aroundX && entering ? quarter : 0,
      rotateYEnd: !aroundX && !entering ? quarter : 0,
      duration: duration,
      delay: delay,
      curve: curve,
      playWhenVisible: playWhenVisible,
    );
  }
}
