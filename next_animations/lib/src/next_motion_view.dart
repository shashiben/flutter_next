import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'next_motion.dart';

/// Plays [motion] on [child].
class NextMotionView extends StatelessWidget {
  /// Creates a player for [motion].
  const NextMotionView({
    required this.motion,
    required this.child,
    this.controller,
    this.autoPlay = true,
    super.key,
  });

  /// Fade-in player.
  factory NextMotionView.fadeIn({
    required Widget child,
    NextFadeIn variant = NextFadeIn.fadeIn,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextFadeDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.fadeIn(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        distance: distance,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Fade-out player.
  factory NextMotionView.fadeOut({
    required Widget child,
    NextFadeOut variant = NextFadeOut.fadeOut,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInCubic,
    double distance = kNextFadeDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.fadeOut(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        distance: distance,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Slide player.
  factory NextMotionView.slide({
    required Widget child,
    NextSlide variant = NextSlide.slideInLeft,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    double distance = kNextSlideDistance,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.slide(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        distance: distance,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Zoom player.
  factory NextMotionView.zoom({
    required Widget child,
    NextZoom variant = NextZoom.zoomIn,
    Duration duration = const Duration(milliseconds: 400),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.zoom(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Bounce player.
  factory NextMotionView.bounce({
    required Widget child,
    NextBounce variant = NextBounce.bounceIn,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve? curve,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.bounce(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Flip player.
  factory NextMotionView.flip({
    required Widget child,
    NextFlip variant = NextFlip.flipInX,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOut,
    AnimationController? controller,
    bool autoPlay = true,
    bool playWhenVisible = false,
    Key? key,
  }) {
    return NextMotionView(
      key: key,
      motion: NextMotion.flip(
        variant,
        duration: duration,
        delay: delay,
        curve: curve,
        playWhenVisible: playWhenVisible,
      ),
      controller: controller,
      autoPlay: autoPlay,
      child: child,
    );
  }

  /// Motion to play.
  final NextMotion motion;

  /// Widget that moves. It is built once per player, not once per frame.
  final Widget child;

  /// Controller owned by the caller. It is not disposed here.
  final AnimationController? controller;

  /// Plays automatically. Ignored when [motion.playWhenVisible] is true.
  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return _NextMotionFrame(motion: motion, t: 1, child: child);
    }
    final external = controller;
    if (external != null) {
      return _DrivenMotion(
        motion: motion,
        controller: external,
        autoPlay: autoPlay,
        child: child,
      );
    }
    return _OwnedMotion(motion: motion, autoPlay: autoPlay, child: child);
  }
}

class _OwnedMotion extends StatefulWidget {
  const _OwnedMotion({
    required this.motion,
    required this.autoPlay,
    required this.child,
  });

  final NextMotion motion;
  final bool autoPlay;
  final Widget child;

  @override
  State<_OwnedMotion> createState() => _OwnedMotionState();
}

class _OwnedMotionState extends State<_OwnedMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Key _visibilityKey = UniqueKey();
  var _played = false;

  Duration get _total {
    final total = widget.motion.delay + widget.motion.duration;
    if (total == Duration.zero) {
      return const Duration(milliseconds: 1);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _total);
    if (!widget.motion.playWhenVisible && widget.autoPlay) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_OwnedMotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.motion.delay != widget.motion.delay ||
        oldWidget.motion.duration != widget.motion.duration) {
      _controller.duration = _total;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final frame = AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return _NextMotionFrame(
          motion: widget.motion,
          t: nextMotionT(
            t: _controller.value,
            delay: widget.motion.delay,
            duration: widget.motion.duration,
            curve: widget.motion.curve,
          ),
          child: child!,
        );
      },
    );
    if (!widget.motion.playWhenVisible) {
      return frame;
    }
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (_played || info.visibleFraction <= 0.2) {
          return;
        }
        _played = true;
        _controller.forward();
      },
      child: frame,
    );
  }
}

class _DrivenMotion extends StatefulWidget {
  const _DrivenMotion({
    required this.motion,
    required this.controller,
    required this.autoPlay,
    required this.child,
  });

  final NextMotion motion;
  final AnimationController controller;
  final bool autoPlay;
  final Widget child;

  @override
  State<_DrivenMotion> createState() => _DrivenMotionState();
}

class _DrivenMotionState extends State<_DrivenMotion> {
  @override
  void initState() {
    super.initState();
    if (widget.autoPlay && !widget.motion.playWhenVisible) {
      widget.controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      child: widget.child,
      builder: (context, child) {
        return _NextMotionFrame(
          motion: widget.motion,
          t: nextMotionT(
            t: widget.controller.value,
            delay: widget.motion.delay,
            duration: widget.motion.duration,
            curve: widget.motion.curve,
          ),
          child: child!,
        );
      },
    );
  }
}

class _NextMotionFrame extends StatelessWidget {
  const _NextMotionFrame({
    required this.motion,
    required this.t,
    required this.child,
  });

  final NextMotion motion;
  final double t;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final opacity = _lerp(
      motion.opacityBegin,
      motion.opacityEnd,
    ).clamp(0.0, 1.0).toDouble();
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..translateByDouble(
        _lerp(motion.dxBegin, motion.dxEnd),
        _lerp(motion.dyBegin, motion.dyEnd),
        0,
        1,
      )
      ..rotateX(_lerp(motion.rotateXBegin, motion.rotateXEnd))
      ..rotateY(_lerp(motion.rotateYBegin, motion.rotateYEnd))
      ..scaleByDouble(
        _lerp(motion.scaleBegin, motion.scaleEnd),
        _lerp(motion.scaleBegin, motion.scaleEnd),
        1,
        1,
      );
    return Opacity(
      opacity: opacity,
      child: Transform(
        alignment: Alignment.center,
        transform: matrix,
        filterQuality: FilterQuality.low,
        child: child,
      ),
    );
  }

  double _lerp(double begin, double end) {
    if (begin == end) {
      return begin;
    }
    return begin + (end - begin) * t;
  }
}
