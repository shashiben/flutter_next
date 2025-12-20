import 'package:flutter/material.dart';
import '../enums.dart';

/// A zoom animation widget that scales its child in or out.
///
/// This widget can zoom in or zoom out with a smooth scaling animation.
/// The animation starts automatically when the widget is built, providing
/// smooth and polished transitions.
///
/// **Example:**
/// ```dart
/// NextZoomAnimation(
///   variant: NextZoomVariant.zoomIn,
///   duration: Duration(milliseconds: 500),
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class NextZoomAnimation extends StatefulWidget {
  /// Creates a [NextZoomAnimation].
  ///
  /// The [child] argument must not be null.
  const NextZoomAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.variant = NextZoomVariant.zoomIn,
    this.controller,
    this.autoStart = true,
    this.curve = Curves.easeOut,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the zoom animation.
  ///
  /// Defaults to 800ms for a smooth, polished feel.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The zoom variant (zoom in or zoom out).
  final NextZoomVariant variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeOut] for smooth, natural motion.
  final Curve curve;

  @override
  State<NextZoomAnimation> createState() => _NextZoomAnimationState();
}

class _NextZoomAnimationState extends State<NextZoomAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = _getScaleTween().animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    _opacityAnimation = _getOpacityTween().animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.variant == NextZoomVariant.zoomIn
            ? const Interval(0, 0.65)
            : const Interval(0.35, 1.0),
      ),
    );

    if (widget.autoStart) {
      if (widget.delay > Duration.zero) {
        Future<void>.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }

  /// Gets the scale tween based on the zoom variant.
  Tween<double> _getScaleTween() {
    switch (widget.variant) {
      case NextZoomVariant.zoomIn:
        return Tween<double>(begin: 0.0, end: 1.0);
      case NextZoomVariant.zoomOut:
        return Tween<double>(begin: 1.0, end: 0.0);
    }
  }

  /// Gets the opacity tween based on the zoom variant.
  Tween<double> _getOpacityTween() {
    switch (widget.variant) {
      case NextZoomVariant.zoomIn:
        return Tween<double>(begin: 0.0, end: 1.0);
      case NextZoomVariant.zoomOut:
        return Tween<double>(begin: 1.0, end: 0.0);
    }
  }
}
