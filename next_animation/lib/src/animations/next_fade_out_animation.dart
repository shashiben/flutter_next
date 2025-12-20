import 'package:flutter/material.dart';
import '../enums.dart';

/// A fade-out animation widget that smoothly fades out its child.
///
/// This widget can fade out to different directions (left, right, top, bottom)
/// or simply fade out opacity. The animation starts automatically when the widget
/// is built, providing smooth and polished transitions.
///
/// **Example:**
/// ```dart
/// NextFadeOutAnimation(
///   variant: NextFadeOutVariant.fadeOutRight,
///   duration: Duration(milliseconds: 500),
///   child: Text('Fading out!'),
/// )
/// ```
class NextFadeOutAnimation extends StatefulWidget {
  /// Creates a [NextFadeOutAnimation].
  ///
  /// The [child] argument must not be null.
  const NextFadeOutAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.variant,
    this.controller,
    this.autoStart = true,
    this.initialPosition = 100,
    this.curve = Curves.easeIn,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the fade-out animation.
  ///
  /// Defaults to 800ms for a smooth, polished feel.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The direction to which the fade-out should occur.
  ///
  /// If null, the widget will only fade out opacity without movement.
  final NextFadeOutVariant? variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The initial position offset for directional fade-out animations.
  ///
  /// This determines how far the widget moves during the fade-out.
  /// Defaults to 100 pixels for a smooth effect.
  final double initialPosition;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeIn] for smooth, natural motion.
  final Curve curve;

  @override
  State<NextFadeOutAnimation> createState() => _NextFadeOutAnimationState();
}

class _NextFadeOutAnimationState extends State<NextFadeOutAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _positionAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    if (widget.variant == null) {
      _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.35, 1.0),
        ),
      );
      _positionAnimation = _opacityAnimation; // Not used but needs to be initialized
    } else {
      _positionAnimation = _getTween().animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
      _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.35, 1.0),
        ),
      );
    }

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
    if (widget.variant == null) {
      return AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: 1.0 - _opacityAnimation.value,
            child: widget.child,
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _getOffset(_positionAnimation.value),
          child: Opacity(
            opacity: 1.0 - _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }

  /// Gets the offset based on the fade-out variant.
  Offset _getOffset(double animation) {
    switch (widget.variant) {
      case NextFadeOutVariant.fadeOutTop:
      case NextFadeOutVariant.fadeOutBottom:
        return Offset(0, animation);
      case NextFadeOutVariant.fadeOutLeft:
      case NextFadeOutVariant.fadeOutRight:
        return Offset(animation, 0);
      case null:
        return Offset.zero;
    }
  }

  /// Gets the tween based on the fade-out variant.
  Tween<double> _getTween() {
    switch (widget.variant) {
      case NextFadeOutVariant.fadeOutTop:
        return Tween<double>(begin: 0, end: widget.initialPosition);
      case NextFadeOutVariant.fadeOutBottom:
        return Tween<double>(begin: 0, end: -widget.initialPosition);
      case NextFadeOutVariant.fadeOutLeft:
        return Tween<double>(begin: 0, end: -widget.initialPosition);
      case NextFadeOutVariant.fadeOutRight:
        return Tween<double>(begin: 0, end: widget.initialPosition);
      case null:
        return Tween<double>(begin: 0, end: 0);
    }
  }
}
