import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../utils/variant_utils.dart';

/// Foreground, background, and border for one variant.
class NextColorSet {
  /// Creates a color set.
  const NextColorSet({
    required this.foreground,
    required this.background,
    required this.border,
  });

  /// Text and icon color.
  final Color foreground;

  /// Fill color.
  final Color background;

  /// Border and accent color.
  final Color border;

  /// Linear blend toward [other].
  NextColorSet lerp(NextColorSet other, double t) {
    return NextColorSet(
      foreground: Color.lerp(foreground, other.foreground, t) ?? foreground,
      background: Color.lerp(background, other.background, t) ?? background,
      border: Color.lerp(border, other.border, t) ?? border,
    );
  }

  /// The alert color object used by [NextAlert].
  NextAlertColorUtil get alert => NextAlertColorUtil(
    color: foreground,
    backgroundColor: background,
    borderColor: border,
  );
}

/// Variant colors for buttons, alerts, and surfaces.
class NextColors extends ThemeExtension<NextColors> {
  /// Creates a full set of variant colors.
  const NextColors({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.light,
    required this.dark,
  });

  /// Colors from [scheme], with fixed success, warning, and info pairs.
  factory NextColors.fromScheme(ColorScheme scheme) {
    final darkMode = scheme.brightness == Brightness.dark;
    return NextColors(
      primary: NextColorSet(
        foreground: scheme.onPrimaryContainer,
        background: scheme.primaryContainer,
        border: scheme.primary,
      ),
      secondary: NextColorSet(
        foreground: scheme.onSecondaryContainer,
        background: scheme.secondaryContainer,
        border: scheme.secondary,
      ),
      danger: NextColorSet(
        foreground: scheme.onErrorContainer,
        background: scheme.errorContainer,
        border: scheme.error,
      ),
      success: _tone(NextAlertColorUtil.success, darkMode),
      warning: _tone(NextAlertColorUtil.warning, darkMode),
      info: _tone(NextAlertColorUtil.info, darkMode),
      light: _tone(NextAlertColorUtil.light, darkMode),
      dark: _tone(NextAlertColorUtil.dark, darkMode),
    );
  }

  /// Primary variant.
  final NextColorSet primary;

  /// Secondary variant.
  final NextColorSet secondary;

  /// Success variant.
  final NextColorSet success;

  /// Danger variant.
  final NextColorSet danger;

  /// Warning variant.
  final NextColorSet warning;

  /// Info variant.
  final NextColorSet info;

  /// Light variant.
  final NextColorSet light;

  /// Dark variant.
  final NextColorSet dark;

  static NextColorSet _tone(NextAlertColorUtil util, bool darkMode) {
    if (!darkMode) {
      return NextColorSet(
        foreground: util.color,
        background: util.backgroundColor,
        border: util.borderColor,
      );
    }
    return NextColorSet(
      foreground: util.backgroundColor,
      background: util.color,
      border: util.borderColor,
    );
  }

  /// The active extension, or colors derived from the current [ColorScheme].
  static NextColors of(BuildContext context) {
    return Theme.of(context).extension<NextColors>() ??
        NextColors.fromScheme(Theme.of(context).colorScheme);
  }

  /// Colors for [variant]. [NextVariant.custom] uses [primary].
  NextColorSet setFor(NextVariant variant) {
    return switch (variant) {
      NextVariant.primary || NextVariant.custom => primary,
      NextVariant.secondary => secondary,
      NextVariant.success => success,
      NextVariant.danger => danger,
      NextVariant.warning => warning,
      NextVariant.info => info,
      NextVariant.light => light,
      NextVariant.dark => dark,
    };
  }

  @override
  NextColors copyWith({
    NextColorSet? primary,
    NextColorSet? secondary,
    NextColorSet? success,
    NextColorSet? danger,
    NextColorSet? warning,
    NextColorSet? info,
    NextColorSet? light,
    NextColorSet? dark,
  }) {
    return NextColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      light: light ?? this.light,
      dark: dark ?? this.dark,
    );
  }

  @override
  NextColors lerp(ThemeExtension<NextColors>? other, double t) {
    if (other is! NextColors) {
      return this;
    }
    return NextColors(
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      success: success.lerp(other.success, t),
      danger: danger.lerp(other.danger, t),
      warning: warning.lerp(other.warning, t),
      info: info.lerp(other.info, t),
      light: light.lerp(other.light, t),
      dark: dark.lerp(other.dark, t),
    );
  }
}
