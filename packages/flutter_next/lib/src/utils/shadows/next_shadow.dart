import 'package:flutter/material.dart';

/// Elevation presets that follow [ColorScheme.shadow] unless [color] is set.
class NextShadow {
  /// Creates a shadow helper. Use the static presets instead.
  const NextShadow._();

  /// Soft shadow.
  static List<BoxShadow> shadow100(BuildContext context, {Color? color}) =>
      _pair(context, color, 4, 4, -2, 0.08, 2, 4, -2, 0.12);

  /// Slightly lifted shadow.
  static List<BoxShadow> shadow200(BuildContext context, {Color? color}) =>
      _pair(context, color, 8, 8, -4, 0.08, 4, 6, -4, 0.12);

  /// Card shadow.
  static List<BoxShadow> shadow300(BuildContext context, {Color? color}) =>
      _pair(context, color, 8, 16, -6, 0.08, 6, 8, -6, 0.12);

  /// Raised shadow.
  static List<BoxShadow> shadow400(BuildContext context, {Color? color}) =>
      _pair(context, color, 8, 24, -4, 0.08, 6, 12, -6, 0.12);

  /// High shadow.
  static List<BoxShadow> shadow500(BuildContext context, {Color? color}) =>
      _pair(context, color, 10, 32, -4, 0.10, 6, 14, -6, 0.12);

  /// Higher shadow.
  static List<BoxShadow> shadow600(BuildContext context, {Color? color}) =>
      _pair(context, color, 12, 42, -4, 0.12, 8, 18, -6, 0.12);

  /// Overlay shadow.
  static List<BoxShadow> shadow700(BuildContext context, {Color? color}) =>
      _pair(context, color, 14, 64, -4, 0.12, 8, 22, -6, 0.12);

  /// Highest preset.
  static List<BoxShadow> shadow800(BuildContext context, {Color? color}) =>
      _pair(context, color, 18, 88, -4, 0.14, 8, 28, -6, 0.12);

  /// Preset for [level], from 100 through 800.
  static List<BoxShadow> level(
    BuildContext context,
    int level, {
    Color? color,
  }) {
    return switch (level) {
      <= 100 => shadow100(context, color: color),
      <= 200 => shadow200(context, color: color),
      <= 300 => shadow300(context, color: color),
      <= 400 => shadow400(context, color: color),
      <= 500 => shadow500(context, color: color),
      <= 600 => shadow600(context, color: color),
      <= 700 => shadow700(context, color: color),
      _ => shadow800(context, color: color),
    };
  }

  static List<BoxShadow> _pair(
    BuildContext context,
    Color? color,
    double dy1,
    double blur1,
    double spread1,
    double alpha1,
    double dy2,
    double blur2,
    double spread2,
    double alpha2,
  ) {
    final base = color ?? Theme.of(context).colorScheme.shadow;
    return <BoxShadow>[
      BoxShadow(
        offset: Offset(0, dy1),
        blurRadius: blur1,
        spreadRadius: spread1,
        color: base.withValues(alpha: alpha1),
      ),
      BoxShadow(
        offset: Offset(0, dy2),
        blurRadius: blur2,
        spreadRadius: spread2,
        color: base.withValues(alpha: alpha2),
      ),
    ];
  }
}
