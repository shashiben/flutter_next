/// 📏 Enum representing all supported screen breakpoints
enum Breakpoint {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}

/// List of breakpoints in order from smallest to largest
const List<Breakpoint> kBreakpoints = [
  Breakpoint.xs,
  Breakpoint.sm,
  Breakpoint.md,
  Breakpoint.lg,
  Breakpoint.xl,
  Breakpoint.xxl,
];

/// Returns the string label of a [Breakpoint] enum
String breakpointToString(Breakpoint bp) {
  return bp.name; // .name returns 'xs', 'sm', etc. in Dart >=2.15
}

/// Configuration class for Bootstrap breakpoints.
///
/// Bootstrap 5.3 default breakpoints:
/// - xs: 0 (no min-width, default)
/// - sm: 576px
/// - md: 768px
/// - lg: 992px
/// - xl: 1200px
/// - xxl: 1400px
class BreakpointConfig {
  /// Bootstrap 5.3 default breakpoint values
  static const Map<Breakpoint, double> _defaultBreakpoints = {
    Breakpoint.xs: 0,
    Breakpoint.sm: 576,
    Breakpoint.md: 768,
    Breakpoint.lg: 992,
    Breakpoint.xl: 1200,
    Breakpoint.xxl: 1400,
  };

  /// Current breakpoint configuration
  static Map<Breakpoint, double> _breakpoints = Map.from(_defaultBreakpoints);

  /// Configure breakpoints with custom values.
  ///
  /// **Example:**
  /// ```dart
  /// FlutterNext.configureBreakpoints(
  ///   sm: 600,
  ///   md: 800,
  ///   lg: 1000,
  /// );
  /// ```
  ///
  /// Only specified breakpoints will be updated; others remain at their defaults.
  /// Breakpoints must be in ascending order (xs < sm < md < lg < xl < xxl).
  static void configure({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    final newBreakpoints = Map<Breakpoint, double>.from(_breakpoints);

    if (xs != null) {
      newBreakpoints[Breakpoint.xs] = xs;
    }
    if (sm != null) {
      newBreakpoints[Breakpoint.sm] = sm;
    }
    if (md != null) {
      newBreakpoints[Breakpoint.md] = md;
    }
    if (lg != null) {
      newBreakpoints[Breakpoint.lg] = lg;
    }
    if (xl != null) {
      newBreakpoints[Breakpoint.xl] = xl;
    }
    if (xxl != null) {
      newBreakpoints[Breakpoint.xxl] = xxl;
    }

    // Validate breakpoints are in ascending order
    _validateBreakpoints(newBreakpoints);

    _breakpoints = newBreakpoints;
  }

  /// Validates that breakpoints are in ascending order
  static void _validateBreakpoints(Map<Breakpoint, double> breakpoints) {
    final values = [
      breakpoints[Breakpoint.xs]!,
      breakpoints[Breakpoint.sm]!,
      breakpoints[Breakpoint.md]!,
      breakpoints[Breakpoint.lg]!,
      breakpoints[Breakpoint.xl]!,
      breakpoints[Breakpoint.xxl]!,
    ];

    for (int i = 1; i < values.length; i++) {
      if (values[i] <= values[i - 1]) {
        throw ArgumentError(
          'Breakpoints must be in ascending order. '
          'Got: xs=${values[0]}, sm=${values[1]}, md=${values[2]}, '
          'lg=${values[3]}, xl=${values[4]}, xxl=${values[5]}',
        );
      }
    }
  }

  /// Gets the configured breakpoint value for a given breakpoint
  static double getBreakpointValue(Breakpoint breakpoint) {
    return _breakpoints[breakpoint] ?? _defaultBreakpoints[breakpoint]!;
  }

  /// Gets all configured breakpoint values
  static Map<Breakpoint, double> getBreakpoints() {
    return Map.from(_breakpoints);
  }

  /// Resets breakpoints to Bootstrap 5.3 defaults
  static void reset() {
    _breakpoints = Map.from(_defaultBreakpoints);
  }
}

/// 🧠 Get the breakpoint based on screen width using configured breakpoint values.
///
/// Uses Bootstrap 5.3 default breakpoints (configurable via `FlutterNext.configureBreakpoints`):
/// | Width      | Breakpoint | Default Value |
/// |------------|------------|---------------|
/// | ≥ 1400     | xxl        | 1400px        |
/// | ≥ 1200     | xl         | 1200px        |
/// | ≥ 992      | lg         | 992px         |
/// | ≥ 768      | md         | 768px         |
/// | ≥ 576      | sm         | 576px         |
/// | < 576      | xs         | 0px           |
///
/// **Example:**
/// ```dart
/// final breakpoint = breakpointForWidth(800); // Returns Breakpoint.md (if default breakpoints)
/// ```
///
/// **Note:** Breakpoints can be customized using `FlutterNext.configureBreakpoints()`.
Breakpoint breakpointForWidth(double width) {
  // Check from largest to smallest breakpoint
  if (width >= BreakpointConfig.getBreakpointValue(Breakpoint.xxl)) {
    return Breakpoint.xxl;
  }
  if (width >= BreakpointConfig.getBreakpointValue(Breakpoint.xl)) {
    return Breakpoint.xl;
  }
  if (width >= BreakpointConfig.getBreakpointValue(Breakpoint.lg)) {
    return Breakpoint.lg;
  }
  if (width >= BreakpointConfig.getBreakpointValue(Breakpoint.md)) {
    return Breakpoint.md;
  }
  if (width >= BreakpointConfig.getBreakpointValue(Breakpoint.sm)) {
    return Breakpoint.sm;
  }
  return Breakpoint.xs;
}
