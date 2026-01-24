import 'responsive_breakpoints.dart';

/// Main class for Flutter Next configuration and utilities.
class FlutterNext {
  FlutterNext._(); // Private constructor to prevent instantiation

  /// Number of columns in the grid system.
  /// Default: 12 (Bootstrap standard)
  ///
  /// **Example:**
  /// ```dart
  /// void main() {
  ///   // Use 16-column grid instead of 12
  ///   FlutterNext.noOfColumns = 16;
  ///   runApp(MyApp());
  /// }
  /// ```
  static int noOfColumns = 12;

  /// Configure Bootstrap breakpoints for responsive layouts.
  ///
  /// **Bootstrap 5.3 Default Values:**
  /// - xs: 0 (no min-width, default)
  /// - sm: 576px
  /// - md: 768px
  /// - lg: 992px
  /// - xl: 1200px
  /// - xxl: 1400px
  ///
  /// **Example:**
  /// ```dart
  /// void main() {
  ///   // Configure custom breakpoints
  ///   FlutterNext.configureBreakpoints(
  ///     sm: 600,
  ///     md: 800,
  ///     lg: 1000,
  ///   );
  ///
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// Only specified breakpoints will be updated; others remain at their defaults.
  /// Breakpoints must be in ascending order (xs < sm < md < lg < xl < xxl).
  static void configureBreakpoints({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    BreakpointConfig.configure(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
    );
  }

  /// Reset breakpoints to Bootstrap 5.3 defaults.
  ///
  /// **Example:**
  /// ```dart
  /// FlutterNext.resetBreakpoints();
  /// ```
  static void resetBreakpoints() {
    BreakpointConfig.reset();
  }
}
