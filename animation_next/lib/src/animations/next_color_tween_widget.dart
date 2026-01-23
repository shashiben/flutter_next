import 'package:flutter/material.dart';

/// A widget that smoothly transitions between two colors.
///
/// This widget provides a color tween animation that can be controlled
/// programmatically. It's useful for hover effects, state changes, and
/// interactive UI elements. The animation can be controlled via the provided
/// controller.
///
/// **Example:**
/// ```dart
/// NextColorTweenWidget(
///   beginColor: Colors.blue,
///   endColor: Colors.red,
///   duration: Duration(milliseconds: 500),
///   child: (controller, color) {
///     return GestureDetector(
///       onTap: () {
///         if (controller.isCompleted) {
///           controller.reverse();
///         } else {
///           controller.forward();
///         }
///       },
///       child: Container(
///         width: 100,
///         height: 100,
///         color: color,
///       ),
///     );
///   },
/// )
/// ```
class NextColorTweenWidget extends StatefulWidget {
  /// Creates a [NextColorTweenWidget].
  ///
  /// The [beginColor], [endColor], and [child] arguments must not be null.
  const NextColorTweenWidget({
    super.key,
    required this.beginColor,
    required this.endColor,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.controller,
    this.autoStart = false,
    this.curve = Curves.easeInOut,
  });

  /// The starting color of the animation.
  final Color beginColor;

  /// The ending color of the animation.
  final Color endColor;

  /// The child builder function.
  ///
  /// This function receives the animation controller and the current
  /// interpolated color value. You can use the controller to manually
  /// control the animation (forward, reverse, etc.).
  final Widget Function(AnimationController controller, Color? color) child;

  /// The duration of the color transition.
  ///
  /// Defaults to 300ms for smooth, responsive transitions.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// Optional animation controller.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  /// This allows you to control the animation externally.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// Defaults to false since color tween is typically controlled manually.
  final bool autoStart;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeInOut] for smooth, natural color transitions.
  final Curve curve;

  @override
  State<NextColorTweenWidget> createState() => _NextColorTweenWidgetState();
}

class _NextColorTweenWidgetState extends State<NextColorTweenWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _colorAnimation = ColorTween(
      begin: widget.beginColor,
      end: widget.endColor,
    ).animate(
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
      animation: _colorAnimation,
      builder: (context, child) {
        return widget.child(_controller, _colorAnimation.value);
      },
    );
  }
}
