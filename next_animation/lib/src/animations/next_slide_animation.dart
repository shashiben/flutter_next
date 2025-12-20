import 'package:flutter/material.dart';
import '../enums.dart';

/// A slide animation widget that slides its child into view.
///
/// This widget can slide in from different directions (left, right, top, bottom).
/// The animation starts automatically when the widget is built, providing
/// smooth and polished transitions.
///
/// **Example:**
/// ```dart
/// NextSlideAnimation(
///   variant: NextSlideVariant.slideInLeft,
///   duration: Duration(milliseconds: 500),
///   child: Text('Sliding in!'),
/// )
/// ```
class NextSlideAnimation extends StatefulWidget {
  /// Creates a [NextSlideAnimation].
  ///
  /// The [child] argument must not be null.
  const NextSlideAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.variant = NextSlideVariant.slideInLeft,
    this.controller,
    this.autoStart = true,
    this.initialPosition = 100,
    this.curve = Curves.easeOut,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the slide animation.
  ///
  /// Defaults to 800ms for a smooth, polished feel.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The direction from which the slide should occur.
  final NextSlideVariant variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The initial position offset for the slide animation.
  ///
  /// This determines how far the widget starts from its final position.
  /// Defaults to 100 pixels.
  final double initialPosition;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeOut] for smooth, natural motion.
  final Curve curve;

  @override
  State<NextSlideAnimation> createState() => _NextSlideAnimationState();
}

class _NextSlideAnimationState extends State<NextSlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _animation = _getTween().animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
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
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _getOffset(_animation.value),
          child: widget.child,
        );
      },
    );
  }

  /// Gets the offset based on the slide variant.
  Offset _getOffset(double animation) {
    switch (widget.variant) {
      case NextSlideVariant.slideInTop:
        return Offset(0, animation);
      case NextSlideVariant.slideInBottom:
        return Offset(0, animation);
      case NextSlideVariant.slideInLeft:
      case NextSlideVariant.slideInRight:
        return Offset(animation, 0);
    }
  }

  /// Gets the tween based on the slide variant.
  Tween<double> _getTween() {
    switch (widget.variant) {
      case NextSlideVariant.slideInTop:
        return Tween<double>(begin: -widget.initialPosition, end: 0);
      case NextSlideVariant.slideInBottom:
        return Tween<double>(begin: widget.initialPosition, end: 0);
      case NextSlideVariant.slideInLeft:
        return Tween<double>(begin: -widget.initialPosition, end: 0);
      case NextSlideVariant.slideInRight:
        return Tween<double>(begin: widget.initialPosition, end: 0);
    }
  }
}
