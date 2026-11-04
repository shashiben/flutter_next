import 'package:flutter/widgets.dart';

/// Animates to [end] whenever it changes.
class NextColorTween extends StatelessWidget {
  /// Creates a color tween.
  const NextColorTween({
    required this.end,
    required this.builder,
    this.begin,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    super.key,
  });

  /// Color before the first build. Defaults to [end].
  final Color? begin;

  /// Target color. Changing it replays the tween.
  final Color end;

  /// Length of the blend.
  final Duration duration;

  /// Curve of the blend.
  final Curve curve;

  /// Builds with the current color.
  final Widget Function(BuildContext context, Color? color) builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: begin ?? end, end: end),
      duration: duration,
      curve: curve,
      builder: (context, color, _) => builder(context, color),
    );
  }
}
