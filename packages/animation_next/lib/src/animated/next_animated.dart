import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'next_animation.dart';

/// Plays a list of [NextAnimation]s on [child].
///
/// One clock drives the list. The child is built when this widget rebuilds,
/// not on every tick. Layers that would change nothing are left out: full
/// opacity, an identity transform, a zero blur, no tint, no clip, no shadow,
/// and no size.
///
/// [NextBlur] and [NextShadow] repaint more than the others. [NextSize] is
/// the one that changes layout.
class NextAnimated extends StatelessWidget {
  /// Creates a player for [animations].
  const NextAnimated({
    required this.animations,
    required this.child,
    this.delay = Duration.zero,
    this.autoPlay = true,
    this.controller,
    this.playWhenVisible = false,
    this.visibleFraction = 0.2,
    this.repeat = 1,
    this.reverse = false,
    this.onComplete,
    this.alignment = Alignment.center,
    this.perspective = 800,
    this.inPoint,
    this.outPoint,
    super.key,
  }) : assert(
         repeat == forever || repeat > 0,
         'repeat is a positive count, or NextAnimated.forever',
       ),
       assert(
         visibleFraction >= 0 && visibleFraction <= 1,
         'visibleFraction is between 0 and 1',
       ),
       assert(perspective != 0, 'perspective cannot be 0');

  /// Repeat until the widget is disposed.
  static const int forever = -1;

  /// Animations, in order. Order matters when two write the same channel.
  final List<NextAnimation> animations;

  /// Widget that moves. Built once per player rebuild, not once per frame.
  final Widget child;

  /// Shifts every animation's start. Does not shift [inPoint] or [outPoint].
  final Duration delay;

  /// Starts playback. Ignored while [playWhenVisible] is waiting.
  final bool autoPlay;

  /// Controller owned by the caller. It is not disposed here.
  ///
  /// Its value is the progress from 0 to 1 across one pass. [autoPlay] calls
  /// [AnimationController.forward] or [AnimationController.repeat] on it.
  final AnimationController? controller;

  /// Starts playback once more than [visibleFraction] of this widget is shown.
  final bool playWhenVisible;

  /// Fraction that counts as on screen. Playback starts above this value.
  final double visibleFraction;

  /// How many forward passes to play. [forever] does not stop.
  ///
  /// With [reverse], each pass plays forward and then back.
  final int repeat;

  /// Plays back to the start after each forward pass.
  final bool reverse;

  /// Called when a finite run finishes. Not called for [forever].
  final VoidCallback? onComplete;

  /// Origin of scale, rotation, and skew.
  final Alignment alignment;

  /// Perspective distance for [NextMove.z] and x/y rotation, in logical pixels.
  final double perspective;

  /// Hides the child before this time on the player clock.
  final Duration? inPoint;

  /// Hides the child after this time on the player clock.
  final Duration? outPoint;

  @override
  Widget build(BuildContext context) {
    final totalUs = _timelineUs(animations, delay);
    if (MediaQuery.disableAnimationsOf(context)) {
      return RepaintBoundary(
        child: _stage(
          pose: NextPose(),
          view: this,
          rawUs: totalUs,
          child: child,
        ),
      );
    }
    final external = controller;
    if (external != null) {
      return _Driven(view: this, totalUs: totalUs, controller: external);
    }
    return _Owned(view: this, totalUs: totalUs);
  }
}

class _Owned extends StatefulWidget {
  const _Owned({required this.view, required this.totalUs});

  final NextAnimated view;
  final int totalUs;

  @override
  State<_Owned> createState() => _OwnedState();
}

class _OwnedState extends State<_Owned> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final NextPose _pose = NextPose();
  final Key _visibilityKey = UniqueKey();
  late int _totalUs;
  var _played = false;

  @override
  void initState() {
    super.initState();
    _totalUs = widget.totalUs;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: _totalUs),
    );
    if (widget.view.autoPlay && !widget.view.playWhenVisible) {
      _start();
    }
  }

  @override
  void didUpdateWidget(_Owned oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalUs != widget.totalUs) {
      _totalUs = widget.totalUs;
      _controller.duration = Duration(microseconds: _totalUs);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_played) {
      return;
    }
    _played = true;
    _run(
      _controller,
      repeat: widget.view.repeat,
      reverse: widget.view.reverse,
      isMounted: () => mounted,
      onComplete: widget.view.onComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _watch(
      view: widget.view,
      visibilityKey: _visibilityKey,
      onVisible: _start,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          child: widget.view.child,
          builder: (context, child) {
            return _stage(
              pose: _pose,
              view: widget.view,
              rawUs: (_totalUs * _controller.value).round(),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

class _Driven extends StatefulWidget {
  const _Driven({
    required this.view,
    required this.totalUs,
    required this.controller,
  });

  final NextAnimated view;
  final int totalUs;
  final AnimationController controller;

  @override
  State<_Driven> createState() => _DrivenState();
}

class _DrivenState extends State<_Driven> {
  final NextPose _pose = NextPose();
  final Key _visibilityKey = UniqueKey();
  var _played = false;

  @override
  void initState() {
    super.initState();
    widget.controller.duration ??= Duration(microseconds: widget.totalUs);
    if (widget.view.autoPlay && !widget.view.playWhenVisible) {
      _start();
    }
  }

  void _start() {
    if (_played) {
      return;
    }
    _played = true;
    _run(
      widget.controller,
      repeat: widget.view.repeat,
      reverse: widget.view.reverse,
      isMounted: () => mounted,
      onComplete: widget.view.onComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _watch(
      view: widget.view,
      visibilityKey: _visibilityKey,
      onVisible: _start,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: widget.controller,
          child: widget.view.child,
          builder: (context, child) {
            return _stage(
              pose: _pose,
              view: widget.view,
              rawUs: (widget.totalUs * widget.controller.value).round(),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

int _timelineUs(List<NextAnimation> animations, Duration delay) {
  var end = 0;
  for (final animation in animations) {
    final at =
        animation.start.inMicroseconds +
        animation.resolvedDuration.inMicroseconds;
    if (at > end) {
      end = at;
    }
  }
  final total = delay.inMicroseconds + end;
  return total <= 0 ? 1 : total;
}

void _run(
  AnimationController controller, {
  required int repeat,
  required bool reverse,
  required bool Function() isMounted,
  required VoidCallback? onComplete,
}) {
  final TickerFuture future;
  if (repeat == NextAnimated.forever) {
    future = controller.repeat(reverse: reverse);
  } else if (reverse) {
    future = controller.repeat(reverse: true, count: repeat * 2);
  } else if (repeat == 1) {
    future = controller.forward(from: 0);
  } else {
    future = controller.repeat(count: repeat);
  }
  if (onComplete == null) {
    return;
  }
  unawaited(
    future.orCancel.then<void>((_) {
      if (isMounted()) {
        onComplete();
      }
    }, onError: (Object _) {}),
  );
}

Widget _watch({
  required NextAnimated view,
  required Key visibilityKey,
  required VoidCallback onVisible,
  required Widget child,
}) {
  if (!view.playWhenVisible) {
    return child;
  }
  return VisibilityDetector(
    key: visibilityKey,
    onVisibilityChanged: (info) {
      if (!view.autoPlay || info.visibleFraction <= view.visibleFraction) {
        return;
      }
      onVisible();
    },
    child: child,
  );
}

Widget _stage({
  required NextPose pose,
  required NextAnimated view,
  required int rawUs,
  required Widget child,
}) {
  final inPoint = view.inPoint;
  final outPoint = view.outPoint;
  final beforeIn = inPoint != null && rawUs < inPoint.inMicroseconds;
  final afterOut = outPoint != null && rawUs > outPoint.inMicroseconds;
  if (beforeIn || afterOut) {
    return Offstage(offstage: true, child: child);
  }
  pose.sampleUs(view.animations, rawUs - view.delay.inMicroseconds);
  return _paint(pose, view, child);
}

Widget _paint(NextPose pose, NextAnimated view, Widget child) {
  var result = child;
  if (pose.blur > 0.01) {
    result = ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: pose.blur, sigmaY: pose.blur),
      child: result,
    );
  }
  final tint = pose.tint;
  if (tint != null && tint.a > 0) {
    result = ColorFiltered(
      colorFilter: ColorFilter.mode(tint, BlendMode.modulate),
      child: result,
    );
  }
  if (pose.radius > 0.01) {
    result = ClipRRect(
      borderRadius: BorderRadius.circular(pose.radius),
      child: result,
    );
  }
  if (pose.reveal < 0.999) {
    result = ClipRect(
      clipper: _RevealClipper(pose.revealEdge, pose.reveal),
      child: result,
    );
  }
  final shadow = pose.shadow;
  if (shadow != null && !_shadowIsNone(shadow)) {
    result = DecoratedBox(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: result,
    );
  }
  if (_moves(pose)) {
    final scaling =
        (pose.scaleX - 1).abs() > 0.001 || (pose.scaleY - 1).abs() > 0.001;
    result = Transform(
      alignment: view.alignment,
      filterQuality: scaling ? FilterQuality.medium : FilterQuality.none,
      transform: _matrix(pose, view.perspective),
      child: result,
    );
  }
  if ((pose.opacity - 1).abs() > 0.001) {
    result = Opacity(
      opacity: pose.opacity.clamp(0.0, 1.0).toDouble(),
      child: result,
    );
  }
  if (pose.width != null || pose.height != null) {
    result = SizedBox(width: pose.width, height: pose.height, child: result);
  }
  return result;
}

bool _moves(NextPose pose) {
  const gap = 0.0001;
  return pose.x.abs() > gap ||
      pose.y.abs() > gap ||
      pose.z.abs() > gap ||
      (pose.scaleX - 1).abs() > gap ||
      (pose.scaleY - 1).abs() > gap ||
      pose.rotateX.abs() > gap ||
      pose.rotateY.abs() > gap ||
      pose.rotateZ.abs() > gap ||
      pose.skewX.abs() > gap ||
      pose.skewY.abs() > gap;
}

Matrix4 _matrix(NextPose pose, double perspective) {
  final matrix = Matrix4.identity();
  final depth =
      pose.z.abs() > 0.001 ||
      pose.rotateX.abs() > 0.001 ||
      pose.rotateY.abs() > 0.001;
  if (depth) {
    matrix.setEntry(3, 2, 1 / perspective);
  }
  matrix
    ..translateByDouble(pose.x, pose.y, pose.z, 1)
    ..rotateX(pose.rotateX)
    ..rotateY(pose.rotateY)
    ..rotateZ(pose.rotateZ);
  if (pose.skewX.abs() > 0.0001 || pose.skewY.abs() > 0.0001) {
    final skew = Matrix4.identity();
    skew.storage[4] = math.tan(pose.skewX);
    skew.storage[1] = math.tan(pose.skewY);
    matrix.multiply(skew);
  }
  matrix.scaleByDouble(pose.scaleX, pose.scaleY, 1, 1);
  return matrix;
}

bool _shadowIsNone(BoxShadow shadow) {
  return shadow.color.a == 0 &&
      shadow.blurRadius == 0 &&
      shadow.spreadRadius == 0 &&
      shadow.offset == Offset.zero;
}

class _RevealClipper extends CustomClipper<Rect> {
  const _RevealClipper(this.edge, this.fraction);

  final NextRevealEdge edge;
  final double fraction;

  @override
  Rect getClip(Size size) {
    final shown = fraction.clamp(0.0, 1.0).toDouble();
    switch (edge) {
      case NextRevealEdge.left:
        return Rect.fromLTWH(0, 0, size.width * shown, size.height);
      case NextRevealEdge.right:
        return Rect.fromLTWH(
          size.width * (1 - shown),
          0,
          size.width * shown,
          size.height,
        );
      case NextRevealEdge.top:
        return Rect.fromLTWH(0, 0, size.width, size.height * shown);
      case NextRevealEdge.bottom:
        return Rect.fromLTWH(
          0,
          size.height * (1 - shown),
          size.width,
          size.height * shown,
        );
      case NextRevealEdge.center:
        final dx = size.width * (1 - shown) / 2;
        final dy = size.height * (1 - shown) / 2;
        return Rect.fromLTRB(dx, dy, size.width - dx, size.height - dy);
    }
  }

  @override
  bool shouldReclip(_RevealClipper oldClipper) {
    return oldClipper.edge != edge || oldClipper.fraction != fraction;
  }
}
