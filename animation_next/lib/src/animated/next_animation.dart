import 'package:flutter/widgets.dart';

import 'next_spring.dart';

/// Default stretch for one animation. A spring's shape is played across this
/// unless [NextAnimation.duration] is null, which uses the spring's settle time.
const Duration kNextAnimationDuration = Duration(milliseconds: 500);

/// One timed change. Put several in a list on `NextAnimated`.
///
/// [curve] wins when both [curve] and [spring] are set. With neither, the
/// easing is [NextSpring.smooth].
abstract class NextAnimation {
  /// Creates a timed animation.
  const NextAnimation({
    this.start = Duration.zero,
    this.duration = kNextAnimationDuration,
    this.curve,
    this.spring,
  });

  /// When this animation begins. Earlier time holds [initial] only if this
  /// is the first animation on that channel.
  final Duration start;

  /// Length of the change. Null plays a spring for [NextSpring.settle] and a
  /// curve for [kNextAnimationDuration].
  final Duration? duration;

  /// Easing. Overrides [spring].
  final Curve? curve;

  /// Spring easing, used when [curve] is null.
  final NextSpring? spring;

  /// The curve that actually drives this animation.
  Curve get easing => curve ?? spring ?? NextSpring.smooth;

  /// Resolved length, including a spring's natural settle time.
  Duration get resolvedDuration {
    final set = duration;
    if (set != null) {
      return set;
    }
    final ease = easing;
    if (ease is NextSpring) {
      return ease.settle;
    }
    return kNextAnimationDuration;
  }

  /// Writes this animation into [pose] at [timeUs] on the player clock.
  void apply(NextPose pose, int timeUs);

  bool _open(int timeUs) => timeUs >= start.inMicroseconds;

  double _progress(int timeUs) {
    final begin = start.inMicroseconds;
    if (timeUs <= begin) {
      return 0;
    }
    final span = resolvedDuration.inMicroseconds;
    if (span <= 0) {
      return 1;
    }
    final elapsed = timeUs - begin;
    if (elapsed >= span) {
      return 1;
    }
    return easing.transform(elapsed / span);
  }
}

/// Opacity.
class NextFade extends NextAnimation {
  /// Fades opacity from [initial] to [to].
  const NextFade({
    required this.to,
    this.initial = 1,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// Opacity at the end.
  final double to;

  /// Opacity before the fade. Defaults to 1.
  final double initial;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._fade) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.opacity = initial + (to - initial) * t;
    pose._fade = true;
  }
}

/// Translation, in logical pixels. Later moves add to earlier ones.
class NextMove extends NextAnimation {
  /// Moves by [x], [y], and [z]. A null axis stays at its initial value.
  const NextMove({
    this.x,
    this.y,
    this.z,
    this.initialX = 0,
    this.initialY = 0,
    this.initialZ = 0,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// Horizontal end offset. Positive is to the right.
  final double? x;

  /// Vertical end offset. Positive is down.
  final double? y;

  /// Depth end offset. Visible when the player has perspective.
  final double? z;

  /// Horizontal offset at the start.
  final double initialX;

  /// Vertical offset at the start.
  final double initialY;

  /// Depth offset at the start.
  final double initialZ;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._move) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.x += _lerp(initialX, x, t);
    pose.y += _lerp(initialY, y, t);
    pose.z += _lerp(initialZ, z, t);
    pose._move = true;
  }
}

/// Scale. Later scales multiply earlier ones.
class NextScale extends NextAnimation {
  /// Scales to [by], or to [x] and [y] separately.
  const NextScale({
    this.by,
    this.x,
    this.y,
    this.initial = 1,
    this.initialX,
    this.initialY,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End scale for both axes, when [x] or [y] is null.
  final double? by;

  /// End horizontal scale.
  final double? x;

  /// End vertical scale.
  final double? y;

  /// Start scale for both axes.
  final double initial;

  /// Start horizontal scale. Defaults to [initial].
  final double? initialX;

  /// Start vertical scale. Defaults to [initial].
  final double? initialY;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._scale) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    final fromX = initialX ?? initial;
    final fromY = initialY ?? initial;
    final sx = fromX + ((x ?? by ?? fromX) - fromX) * t;
    final sy = fromY + ((y ?? by ?? fromY) - fromY) * t;
    if (pose._scale) {
      pose.scaleX *= sx;
      pose.scaleY *= sy;
    } else {
      pose.scaleX = sx;
      pose.scaleY = sy;
      pose._scale = true;
    }
  }
}

/// Rotation in degrees. Later rotations add. Positive is clockwise.
class NextRotate extends NextAnimation {
  /// Rotates to [degrees] around z, and optionally around x and y.
  const NextRotate({
    this.degrees,
    this.degreesX,
    this.degreesY,
    this.initial = 0,
    this.initialX = 0,
    this.initialY = 0,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End rotation around z, in degrees.
  final double? degrees;

  /// End rotation around x, in degrees.
  final double? degreesX;

  /// End rotation around y, in degrees.
  final double? degreesY;

  /// Start rotation around z, in degrees.
  final double initial;

  /// Start rotation around x, in degrees.
  final double initialX;

  /// Start rotation around y, in degrees.
  final double initialY;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._rotate) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.rotateZ += _radians(_lerp(initial, degrees, t));
    pose.rotateX += _radians(_lerp(initialX, degreesX, t));
    pose.rotateY += _radians(_lerp(initialY, degreesY, t));
    pose._rotate = true;
  }
}

/// Skew in degrees. Later skews add.
class NextSkew extends NextAnimation {
  /// Skews to [x] and [y] degrees.
  const NextSkew({
    this.x,
    this.y,
    this.initialX = 0,
    this.initialY = 0,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End horizontal skew, in degrees.
  final double? x;

  /// End vertical skew, in degrees.
  final double? y;

  /// Start horizontal skew, in degrees.
  final double initialX;

  /// Start vertical skew, in degrees.
  final double initialY;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._skew) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.skewX += _radians(_lerp(initialX, x, t));
    pose.skewY += _radians(_lerp(initialY, y, t));
    pose._skew = true;
  }
}

/// Width and height. This is the animation that changes layout.
class NextSize extends NextAnimation {
  /// Sizes to [width] and [height].
  const NextSize({
    this.width,
    this.height,
    this.initialWidth,
    this.initialHeight,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End width. Null leaves the width alone.
  final double? width;

  /// End height. Null leaves the height alone.
  final double? height;

  /// Start width. Defaults to 0 when [width] is set.
  final double? initialWidth;

  /// Start height. Defaults to 0 when [height] is set.
  final double? initialHeight;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    final t = begun ? _progress(timeUs) : 0.0;
    _axis(
      begun: begun,
      seen: pose._width,
      initial: initialWidth,
      to: width,
      t: t,
      write: (value) {
        pose.width = value;
        pose._width = true;
      },
    );
    _axis(
      begun: begun,
      seen: pose._height,
      initial: initialHeight,
      to: height,
      t: t,
      write: (value) {
        pose.height = value;
        pose._height = true;
      },
    );
  }
}

/// Blur sigma. Costly. Prefer fade or scale when many of these play at once.
class NextBlur extends NextAnimation {
  /// Blurs from [initial] to [to].
  const NextBlur({
    required this.to,
    this.initial = 0,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End blur sigma.
  final double to;

  /// Start blur sigma.
  final double initial;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._blur) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.blur = initial + (to - initial) * t;
    pose._blur = true;
  }
}

/// A color laid over the child with [BlendMode.modulate].
class NextTint extends NextAnimation {
  /// Tints from [initial] to [to].
  const NextTint({
    required this.to,
    this.initial = const Color(0x00000000),
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End tint.
  final Color to;

  /// Start tint. Defaults to transparent, which draws nothing.
  final Color initial;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._tint) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.tint = Color.lerp(initial, to, t.clamp(0.0, 1.0).toDouble());
    pose._tint = true;
  }
}

/// Corner radius of a clip around the child.
class NextRadius extends NextAnimation {
  /// Clips to [to] from [initial].
  const NextRadius({
    required this.to,
    this.initial = 0,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// End corner radius.
  final double to;

  /// Start corner radius.
  final double initial;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._radius) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.radius = initial + (to - initial) * t;
    pose._radius = true;
  }
}

/// Which edge a [NextReveal] opens from.
enum NextRevealEdge {
  /// Opens toward the right.
  left,

  /// Opens toward the left.
  right,

  /// Opens downward.
  top,

  /// Opens upward.
  bottom,

  /// Opens out from the center.
  center,
}

/// A clip that reveals the child. [to] and [initial] are fractions from 0 to 1.
class NextReveal extends NextAnimation {
  /// Reveals from [initial] to [to] along [edge].
  const NextReveal({
    this.to = 1,
    this.initial = 0,
    this.edge = NextRevealEdge.left,
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// Visible fraction at the end.
  final double to;

  /// Visible fraction at the start.
  final double initial;

  /// Edge the reveal grows from.
  final NextRevealEdge edge;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._reveal) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.reveal = initial + (to - initial) * t;
    pose.revealEdge = edge;
    pose._reveal = true;
  }
}

/// A shadow behind the child. Costly. One is fine, a long list of them is not.
class NextShadow extends NextAnimation {
  /// Animates a shadow from [initial] to [to].
  const NextShadow({
    required this.to,
    this.initial = const BoxShadow(color: Color(0x00000000)),
    super.start,
    super.duration,
    super.curve,
    super.spring,
  });

  /// Shadow at the end.
  final BoxShadow to;

  /// Shadow at the start. The default draws nothing.
  final BoxShadow initial;

  @override
  void apply(NextPose pose, int timeUs) {
    final begun = _open(timeUs);
    if (!begun && pose._shadow) {
      return;
    }
    final t = begun ? _progress(timeUs) : 0.0;
    pose.shadow = BoxShadow.lerp(initial, to, t.clamp(0.0, 1.0).toDouble());
    pose._shadow = true;
  }
}

/// Channels after every animation in the list has been combined.
///
/// Moves, rotations, and skews add. Scales multiply. Every other channel
/// keeps the latest animation that has started. The first animation on a
/// channel holds its initial value until its start.
class NextPose {
  /// Opacity. 1 when no fade has written.
  double opacity = 1;

  /// Combined horizontal offset.
  double x = 0;

  /// Combined vertical offset.
  double y = 0;

  /// Combined depth offset.
  double z = 0;

  /// Combined horizontal scale.
  double scaleX = 1;

  /// Combined vertical scale.
  double scaleY = 1;

  /// Combined rotation around x, in radians.
  double rotateX = 0;

  /// Combined rotation around y, in radians.
  double rotateY = 0;

  /// Combined rotation around z, in radians.
  double rotateZ = 0;

  /// Combined horizontal skew, in radians.
  double skewX = 0;

  /// Combined vertical skew, in radians.
  double skewY = 0;

  /// Width, if a size animation set one.
  double? width;

  /// Height, if a size animation set one.
  double? height;

  /// Blur sigma.
  double blur = 0;

  /// Tint, if a tint animation set one.
  Color? tint;

  /// Corner radius.
  double radius = 0;

  /// Visible fraction for a reveal. 1 means no clip.
  double reveal = 1;

  /// Edge of [reveal].
  NextRevealEdge revealEdge = NextRevealEdge.left;

  /// Shadow, if a shadow animation set one.
  BoxShadow? shadow;

  bool _fade = false;
  bool _move = false;
  bool _scale = false;
  bool _rotate = false;
  bool _skew = false;
  bool _width = false;
  bool _height = false;
  bool _blur = false;
  bool _tint = false;
  bool _radius = false;
  bool _reveal = false;
  bool _shadow = false;

  /// Resets and applies [animations] at [time].
  ///
  /// [time] is the player clock after its delay. Negative time is before
  /// the first animation.
  void sample(List<NextAnimation> animations, Duration time) {
    sampleUs(animations, time.inMicroseconds);
  }

  /// [sample] with a microsecond clock, so the player can reuse this pose.
  void sampleUs(List<NextAnimation> animations, int timeUs) {
    opacity = 1;
    x = 0;
    y = 0;
    z = 0;
    scaleX = 1;
    scaleY = 1;
    rotateX = 0;
    rotateY = 0;
    rotateZ = 0;
    skewX = 0;
    skewY = 0;
    width = null;
    height = null;
    blur = 0;
    tint = null;
    radius = 0;
    reveal = 1;
    revealEdge = NextRevealEdge.left;
    shadow = null;
    _fade = false;
    _move = false;
    _scale = false;
    _rotate = false;
    _skew = false;
    _width = false;
    _height = false;
    _blur = false;
    _tint = false;
    _radius = false;
    _reveal = false;
    _shadow = false;
    for (final animation in animations) {
      animation.apply(this, timeUs);
    }
  }
}

double _lerp(double initial, double? to, double t) {
  final end = to ?? initial;
  if (initial == end) {
    return initial;
  }
  return initial + (end - initial) * t;
}

double _radians(double degrees) => degrees * 3.141592653589793 / 180;

void _axis({
  required bool begun,
  required bool seen,
  required double? initial,
  required double? to,
  required double t,
  required void Function(double value) write,
}) {
  if (initial == null && to == null) {
    return;
  }
  if (!begun && seen) {
    return;
  }
  final from = initial ?? 0;
  final end = to ?? from;
  write(from + (end - from) * (begun ? t : 0));
}
